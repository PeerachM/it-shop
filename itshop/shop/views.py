from django.shortcuts import render, redirect
from django.views import View

from .models import *
from .forms import *
from django.contrib.auth.models import Group

from django.db.models import Count, Sum, Case, When, F, Q

from django.contrib.auth import login, logout, update_session_auth_hash
from django.contrib.auth.forms import AuthenticationForm, PasswordChangeForm
from django.contrib.auth.mixins import PermissionRequiredMixin
from django.core.exceptions import PermissionDenied

from django.contrib import messages
from django.utils import timezone
from django.db import transaction

def is_admin(user):
    return user.groups.filter(name="admin").exists()

def check_in_wishlist(customer, product_id):
    return customer.wishlist.filter(id=product_id).exists()

def is_cartitem_owner(customer, cartitem):
    return cartitem.objects.filter(customer=customer).exists()

def get_cart_items(customer):
    cart_items = CartItem.objects.filter(customer=customer, product__is_active=True, product__stock__gt=0).annotate(
        sale_price=Case(
            When(product__discount_type="NONE", then=F("product__price")),
            When(product__discount_type="PERCENT", then=(F("product__price") * (1 - F("product__discount_value") / 100))),
            When(product__discount_type="FIXED", then=(F("product__price") - F("product__discount_value"))),
        ), 
        subtotal = F("sale_price") * F("quantity")
    )
    total = cart_items.aggregate(total=Sum("subtotal"))["total"]
    return cart_items, total

class RegisterView(View):
    def get(self, request):
        reg_form = CustomUserCreationForm()
        context = {'form': reg_form}
        return render(request, "auth_templates/register.html", context)

    def post(self, request):
        reg_form = CustomUserCreationForm(request.POST)
        if reg_form.is_valid():
            user = reg_form.save()
            cus_group = Group.objects.get(name="customer")
            user.groups.add(cus_group)
            Customer.objects.create(user=user)

            login(request, user)
            return redirect('product_list')
        
        context = {'form': reg_form}
        return render(request, "auth_templates/register.html", context)

class LoginView(View):
    def get(self, request):
        login_form = AuthenticationForm()
        context = {'form': login_form}
        return render(request, "auth_templates/login.html", context)
    
    def post(self, request):
        login_form = AuthenticationForm(data=request.POST)
        if login_form.is_valid():
            user = login_form.get_user()
            login(request, user)

            path = request.GET.get("next")
            if path:
                return redirect(path)
            elif is_admin(user):
                return redirect('admin_home')
            else:
                return redirect('product_list')

        context = {'form': login_form}
        return render(request, "auth_templates/login.html", context)

class LogoutView(View):
    def get(self, request):
        logout(request)
        return redirect('login')
    
class ChangePasswordView(View):
    def get(self, request):
        form = PasswordChangeForm(user=request.user)
        context = {"form": form}
        return render(request, 'customer_templates/change_password.html', context)
    def post(self, request):
        form = PasswordChangeForm(user=request.user, data=request.POST)
        if form.is_valid():
            user = form.save()
            update_session_auth_hash(request, user)  # Important for keeping the user logged in
            return redirect('profile')
        context = {"form": form}
        return render(request, 'customer_templates/change_password.html', context)

# ---CUSTOMER---

# PRODUCT (customer)
class ProductListView(View):
    def get(self, request):
        search = request.GET.get("search", "")
        category = request.GET.get("category", "all")
        brand = request.GET.get("brand", "all")
        orderby = request.GET.get("sort", "name")

        products = Product.objects.filter(name__icontains=search, is_active=True).annotate(
            sale_price=Case(
                When(discount_type="NONE", then=F("price")),
                When(discount_type="PERCENT", then=(F("price") * (1 - F("discount_value") / 100))),
                When(discount_type="FIXED", then=(F("price") - F("discount_value"))),
            )
        ).order_by(orderby)
        if category!="all":
            products = products.filter(category__name=category)
        if brand!="all":
            products = products.filter(brand__name=brand)

        categories = Category.objects.all()

        if category!="all":
            # เอาเฉพาะ brand ที่มีสินค้าอยู่ใน category นั้นๆ ไปแสดง
            brands = Brand.objects.filter(product__category__name=category).distinct()
        else:
            brands = Brand.objects.all()

        context = {
            "products": products,
            "categories": categories,
            "brands": brands,
            "total": products.count()
            }
        return render(request, "customer_templates/product_list.html", context)
    
class ProductDetailView(View):
    def get(self, request, id):
        product = Product.objects.filter(id=id, is_active=True).annotate(
            sale_price=Case(
                When(discount_type="NONE", then=F("price")),
                When(discount_type="PERCENT", then=(F("price") * (1 - F("discount_value") / 100))),
                When(discount_type="FIXED", then=(F("price") - F("discount_value"))),
            )
        ).first()
        in_wishlist = False
        if request.user.is_authenticated and not is_admin(request.user):
            customer = Customer.objects.get(user=request.user)
            # check ว่ามีอยู่ในรายการ wishlist ไหม
            in_wishlist = check_in_wishlist(customer, product.id)
        context = {
            "product": product,
            "in_wishlist": in_wishlist
        }
        return render(request, "customer_templates/product_detail.html", context)

class EditProfileView(PermissionRequiredMixin, View):
    permission_required = ["shop.change_customer", "auth.change_user"]
    def get(self, request):
        user_form = UserForm(instance=request.user)
        customer_form = CustomerForm(instance=request.user.customer)
        context = {
            "user_form": user_form,
            "customer_form": customer_form,
        }
        return render(request, "customer_templates/profile_edit.html", context)
    def post(self, request):
        user = request.user
        user_form = UserForm(request.POST, instance=user)
        customer_form = CustomerForm(request.POST, request.FILES, instance=user.customer)
        if user_form.is_valid() and customer_form.is_valid():
            user_form.save()
            customer_form.save()
            return redirect("product_list")
        context = {
            "user_form": user_form,
            "customer_form": customer_form,
        }
        return render(request, "customer_templates/profile_edit.html", context)

# ADDRESS
class AddressView(PermissionRequiredMixin, View):
    permission_required = ["shop.view_address"]
    def get(self, request):
        addresses = Address.objects.filter(customer=request.user.customer)
        context = {"addresses": addresses}
        return render(request, "customer_templates/address_list.html", context)

class CreateAddressView(PermissionRequiredMixin, View):
    permission_required = ["shop.add_address"]
    def get(self, request):
        address_form = AddressForm()
        context = {"form": address_form}
        return render(request, "customer_templates/address_create.html", context)
    def post(self, request):
        address_form = AddressForm(request.POST)
        if address_form.is_valid():
            address = address_form.save(commit=False)
            address.customer = request.user.customer
            address.save()
            return redirect("address")
        context = {'form': address_form}
        return render(request, "customer_templates/address_create.html", context)

class EditAddressView(PermissionRequiredMixin, View):
    permission_required = ["shop.view_address", "shop.change_address"]
    def get(self, request, id):
        address = Address.objects.get(id=id)
        if address.customer != request.user.customer:
            raise PermissionDenied()
        address_form = AddressForm(instance=address)
        context = {"form": address_form}
        return render(request, "customer_templates/address_edit.html", context)
    def post(self, request, id):
        address = Address.objects.get(id=id)
        if address.customer != request.user.customer:
            raise PermissionDenied()
        address_form = AddressForm(request.POST, instance=address)
        if address_form.is_valid():
            address_form.save()
            return redirect("address")
        context = {'form': address_form}
        return render(request, "customer_templates/address_edit.html", context)
    
class DeleteAddressView(PermissionRequiredMixin, View):
    permission_required = ["shop.delete_address",]
    def post(self, request, id):
        address = Address.objects.get(id=id)
        if address.customer != request.user.customer:
            raise PermissionDenied()
        address.delete()
        return redirect("address")
    
# WISHLIST
class WishlistView(PermissionRequiredMixin, View):
    permission_required = ["shop.view_customer", "shop.change_customer"]
    def get(self, request):
        customer = Customer.objects.get(user=request.user)
        products = customer.wishlist.all()
        context = {
            "products": products,
            "total": products.count()
        }
        return render(request, "customer_templates/wishlist.html", context)

class AddWishlistView(PermissionRequiredMixin, View):
    permission_required = ["shop.change_customer"]
    def get(self, request, id):
        product = Product.objects.get(id=id, is_active=True)
        customer = Customer.objects.get(user=request.user)
        # check ว่ามีอยู่ในรายการ wishlist ไหม
        in_wishlist = check_in_wishlist(customer, product.id)
        if not in_wishlist:
            customer.wishlist.add(product)
        return redirect("product_detail", id)
    
class RemoveWishlistView(PermissionRequiredMixin, View):
    permission_required = ["shop.change_customer"]
    def get(self, request, id):
        product = Product.objects.get(id=id, is_active=True)
        customer = Customer.objects.get(user=request.user)
        # check ว่ามีอยู่ในรายการ wishlist ไหม
        in_wishlist = check_in_wishlist(customer, product.id)
        if in_wishlist:
            customer.wishlist.remove(product)
        path = request.GET.get("next")
        if path:
            return redirect(path)
        return redirect("wishlist")

# CART
class CartView(PermissionRequiredMixin, View):
    permission_required = ["shop.view_cartitem", "shop.change_cartitem"]
    def get(self, request):
        customer = Customer.objects.get(user=request.user)
        cart_items, total = get_cart_items(customer)
        ex_cart_items = CartItem.objects.filter(Q(customer=customer), (Q(product__is_active=False) |  Q(product__stock=0)))
        context = {
            "cart_items": cart_items,
            "ex_cart_items": ex_cart_items,
            "total": total
        }
        return render(request, "customer_templates/cart.html", context)
    
class AddCartView(PermissionRequiredMixin, View):
    permission_required = ["shop.add_cartitem"]
    def post(self, request, id):
        customer = Customer.objects.get(user=request.user)
        product =  Product.objects.get(id=id, is_active=True, stock__gt=0)
        quantity = int(request.POST.get("quantity"))
        # เช็คว่ามี product นั้น อยู่ใน cart อยู่แล้วไหม ถ้ามี ให้ update quantity
        try:
            cart_item = CartItem.objects.get(customer=customer, product=product)
            cart_item.quantity += quantity
            # ไม่ให้เกิน stock และไม่ให้น้อยกว่า 1
            cart_item.quantity = max(1, min(cart_item.quantity, product.stock))
            cart_item.save()
        except CartItem.DoesNotExist:
            # ไม่ให้เกิน stock และไม่ให้น้อยกว่า 1
            quantity = max(1, min(quantity, product.stock))
            cart_item = CartItem.objects.create(customer=customer, product=product, quantity=quantity)
        return redirect("cart")
    
class RemoveCartView(PermissionRequiredMixin, View):
    permission_required = ["shop.delete_cartitem"]
    def get(self, request, id):
        cart_item = CartItem.objects.get(id=id)
        if cart_item.customer != request.user.customer:
            raise PermissionDenied()
        cart_item.delete()
        
        return redirect("cart")
    
class ChangeCartView(PermissionRequiredMixin, View):
    permission_required = ["shop.change_cartitem"]
    def post(self, request, id):
        cart_item = CartItem.objects.get(id=id)
        if cart_item.customer != request.user.customer:
            raise PermissionDenied()
        quantity = int(request.POST.get("quantity"))
        # ไม่ให้เกิน stock และไม่ให้น้อยกว่า 1
        quantity = max(1, min(quantity, cart_item.product.stock))
        cart_item.quantity = quantity
        cart_item.save()
        return redirect("cart")


# CHECKOUT
class CheckoutView(PermissionRequiredMixin, View):
    permission_required = ["shop.add_order"]
    def get(self, request):
        customer = Customer.objects.get(user=request.user)
        cart_items, total = get_cart_items(customer)
        addresses = Address.objects.filter(customer=customer)

        if not cart_items.exists():
            return redirect("cart")
        
        context = {
            "cart_items": cart_items,
            "addresses": addresses,
            "total": total,
            "discount_code": "",
            "discount_amount": 0,
            "total_after_discount": total,
        }
        return render(request, "customer_templates/checkout.html", context)

    def post(self, request):
        customer = Customer.objects.get(user=request.user)
        cart_items, total = get_cart_items(customer)
        addresses = Address.objects.filter(customer=customer)

        code = request.POST.get("discount_code", "").strip()
        address_id = int(request.POST.get("address_id"))
        discount_amount = 0
        discount_code = None

        action = request.POST.get("action")
        # ถ้ากด ใช้โค้ด
        if action=="apply_code":
            if not code:
                messages.error(request, "กรุณาใส่โค้ดส่วนลด")
            else:
                discount_code, discount_amount = self.validate_discount_code(code, total)
            context = {
                "cart_items": cart_items,
                "addresses": addresses,
                "address_id": address_id,
                "total": total,
                "discount_code": code if discount_code else None,
                "discount_amount": discount_amount,
                "total_after_discount": total - discount_amount,
            }
            return render(request, "customer_templates/checkout.html", context)
        

        # ถ้ากด ยกเลิกใช้โค้ด
        if action=="clear_code":
            context = {
                "cart_items": cart_items,
                "addresses": addresses,
                "address_id": address_id,
                "total": total,
                "discount_code": None,
                "discount_amount": 0,
                "total_after_discount": total - discount_amount,
            }
            return render(request, "customer_templates/checkout.html", context)


        # ถ้ากด ชำระเงิน
        elif action=="checkout":
            # ตรวจสอบโค้ดส่วนลดอีกครั้ง
            print("code", code)
            if code:
                discount_code, discount_amount = self.validate_discount_code(code, total)
            print("amount",discount_code, discount_amount)

            address = Address.objects.filter(id=address_id, customer=customer).first()
            if not address:
                messages.error(request, "กรุณาเลือกที่อยู่จัดส่ง")
                context = {
                    "cart_items": cart_items,
                    "addresses": addresses,
                    "address_id": address_id,
                    "total": total,
                    "discount_code": code if discount_code else None,
                    "discount_amount": discount_amount,
                    "total_after_discount": total - discount_amount,
                }
                return render(request, "customer_templates/checkout.html", context)

            if not cart_items.exists():
                return redirect("cart")
            try:
                with transaction.atomic():
                    order = Order.objects.create(
                        customer=customer,
                        discount_code=discount_code,
                        discount_amount=discount_amount,
                        total_price=total,
                        shipping_address=str(address),
                        status=Order.OrderStatus.PENDING,
                    )
                    for item in cart_items:
                        product = item.product
                        # ตรวจ stock ก่อนหัก
                        if product.stock < item.quantity:
                            raise ValueError(f"สินค้า {product.name} มีไม่พอในคลัง")

                        OrderItem.objects.create(
                            order=order,
                            product=product,
                            quantity=item.quantity,
                            unit_price=item.product.price,
                            discount_price=item.product.price-item.sale_price,
                        )

                        # ลด stock
                        product.stock = F("stock") - item.quantity
                        product.save()

                    # เพิ่ม usage code
                    if discount_code:
                        discount_code.usage_count = F("usage_count") + 1
                        discount_code.save()

                    # ล้างตะกร้า
                    cart_items.delete()
            except ValueError as e:
                messages.error(request, str(e))
                return redirect("cart")

            return redirect("payment", order.id)

    def validate_discount_code(self, code, total):
        # ตรวจสอบว่าโค้ดส่วนลดใช้ได้ไหม
        try:
            discount_code = DiscountCode.objects.get(code=code, is_active=True)
            now = timezone.now()
            if now < discount_code.start_date:
                messages.error(self.request, "โค้ดนี้ยังไม่ถึงเวลาที่สามารถใช้ได้")
                return None, 0
            if discount_code.end_date and now > discount_code.end_date:
                messages.error(self.request, "โค้ดนี้หมดอายุไปแล้ว")
                return None, 0
            if total < discount_code.min_order_amount:
                messages.error(self.request, f"ยอดสั่งซื้อต้องเกิน {discount_code.min_order_amount} บาท ถึงใช้โค้ดนี้ได้")
                return None, 0

            discount_amount = self.calculate_discount(total, discount_code)
            return discount_code, discount_amount
        except DiscountCode.DoesNotExist:
            messages.error(self.request, "โค้ดส่วนลดไม่ถูกต้อง")
            return None, 0

    def calculate_discount(self, total, discount_code):
        # คำนวณส่วนลด
        if discount_code.code_type == DiscountCode.CodeType.PERCENT:
            discount = (discount_code.value / 100) * total
        elif discount_code.code_type == DiscountCode.CodeType.FIXED:
            discount = discount_code.value

        if discount_code.max_discount_amount:
            discount = min(discount, discount_code.max_discount_amount)
        
        return min(discount, total)


# PAYMENT
class PaymentView(PermissionRequiredMixin, View):
    permission_required = ["shop.view_payment", "shop.add_payment"]
    def get(self, request, id):
        order = Order.objects.filter(id=id).annotate(final_price=F("total_price")-F("discount_amount")).first()
        if order.customer != request.user.customer:
            raise PermissionDenied()
        form = PaymentForm()
        context = {
            "order": order,
            "form": form,
        }
        return render(request, "customer_templates/payment.html", context)

    def post(self, request, id):
        order = Order.objects.get(id=id)
        if order.customer != request.user.customer:
            raise PermissionDenied()
        form = PaymentForm(request.POST, request.FILES)

        if form.is_valid():
            payment = form.save(commit=False)
            payment.order = order
            payment.status = Payment.PaymentStatus.PENDING
            payment.save()

            return redirect("product_list")
            # return redirect("order_detail", order_id=order.id)
        context = {
            "order": order,
            "form": form
        }
        return render(request, "customer_templates/payment.html", context)


# ORDER (cutomer)
class OrderListView(PermissionRequiredMixin, View):
    permission_required = ["shop.view_order", "shop.add_payment"]
    def get(self, request):
        customer = Customer.objects.get(user=request.user)
        orders = Order.objects.filter(customer=customer).annotate(final_price=F("total_price")-F("discount_amount")).order_by("-order_date")
        status = request.GET.get("status", "ALL")
        if status == "UNPAID":
            orders = orders.filter(payment__isnull=True).exclude(status="CANCELLED")
        elif status == "PENDING":
            orders = orders.filter(payment__status="PENDING").exclude(status="CANCELLED")
        elif status != "ALL":
            orders = orders.filter(status=status)
        context = {
            "orders": orders,
        }
        return render(request, "customer_templates/order_list.html", context)










# ---ADMIN---

# HOME
class AdminHomeView(PermissionRequiredMixin, View):
    permission_required = ["shop.view_product", "shop.view_order"]
    def get(self, request):
        if not is_admin(request.user):
            raise PermissionDenied("Only for Admin.")
        
        return render(request, "admin_templates/home.html")


# PRODUCT (admin)
class ProductView(PermissionRequiredMixin, View):
    permission_required = ["shop.view_product",]
    def get(self, request):
        if not is_admin(request.user):
            raise PermissionDenied("Only for Admin.")
        
        products = Product.objects.annotate(
            sale_price=Case(
                When(discount_type="NONE", then=F("price")),
                When(discount_type="PERCENT", then=(F("price") * (1 - F("discount_value") / 100))),
                When(discount_type="FIXED", then=(F("price") - F("discount_value"))),
            )
        )
        context = {"products": products}
        return render(request, "admin_templates/product_list.html", context)

class CreateProductView(PermissionRequiredMixin, View):
    permission_required = ["shop.add_product",]
    def get(self, request):
        product_form = ProductForm()
        context = {'form': product_form}
        return render(request, "admin_templates/product_create.html", context)
    
    def post(self, request):
        product_form = ProductForm(request.POST, request.FILES)
        if product_form.is_valid():
            product_form.save()
            return redirect("product")
        context = {'form': product_form}
        return render(request, "admin_templates/product_create.html", context)
    
class EditProductView(PermissionRequiredMixin, View):
    permission_required = ["shop.change_product",]
    def get(self, request, id):
        product = Product.objects.get(id=id)
        product_form = ProductForm(instance=product)
        context = {'form': product_form}
        return render(request, "admin_templates/product_edit.html", context)
    
    def post(self, request, id):
        product = Product.objects.get(id=id)
        product_form = ProductForm(request.POST, request.FILES, instance=product)
        if product_form.is_valid():
            product_form.save()
            return redirect("product")
        context = {'form': product_form}
        return render(request, "admin_templates/product_edit.html", context)

class ActivateProductView(PermissionRequiredMixin, View):
    permission_required = ["shop.change_product",]
    def post(self, request, id):
        product = Product.objects.get(id=id)
        product.is_active = True;
        product.save()
        return redirect('product_edit', id=id)

class DeactivateProductView(PermissionRequiredMixin, View):
    permission_required = ["shop.change_product",]
    def post(self, request, id):
        product = Product.objects.get(id=id)
        product.is_active = False;
        product.save()
        return redirect('product_edit', id=id)



# CATEGORY
class CategoryView(PermissionRequiredMixin, View):
    permission_required = ["shop.view_category",]
    def get(self, request):
        categories = Category.objects.annotate(product_count=Count('product'))
        context = {"categories": categories}
        return render(request, "admin_templates/category_list.html", context)

class CreateCategoryView(PermissionRequiredMixin, View):
    permission_required = ["shop.add_category",]
    def get(self, request):
        category_form = CategoryForm()
        context = {'form': category_form}
        return render(request, "admin_templates/category_create.html", context)
    
    def post(self, request):
        category_form = CategoryForm(request.POST)
        if category_form.is_valid():
            category_form.save()
            return redirect("category")
        context = {'form': category_form}
        return render(request, "admin_templates/category_create.html", context)
    
class EditCategoryView(PermissionRequiredMixin, View):
    permission_required = ["shop.change_category",]
    def get(self, request, id):
        category = Category.objects.get(id=id)
        category_form = CategoryForm(instance=category)
        context = {'form': category_form}
        return render(request, "admin_templates/category_edit.html", context)
    
    def post(self, request, id):
        category = Category.objects.get(id=id)
        category_form = CategoryForm(request.POST, instance=category)
        if category_form.is_valid():
            category_form.save()
            return redirect("category")
        context = {'form': category_form}
        return render(request, "admin_templates/category_edit.html", context)

class DeleteCategoryView(PermissionRequiredMixin, View):
    permission_required = ["shop.delete_category",]
    def get(self, request, id):
        category = Category.objects.get(id=id)
        category.delete()
        return redirect("category")


# BRAND
class BrandView(PermissionRequiredMixin, View):
    permission_required = ["shop.view_brand",]
    def get(self, request):
        brands = Brand.objects.annotate(product_count=Count('product'))
        context = {"brands": brands}
        return render(request, "admin_templates/brand_list.html", context)

class CreateBrandView(PermissionRequiredMixin, View):
    permission_required = ["shop.add_brand",]
    def get(self, request):
        brand_form = BrandForm()
        context = {'form': brand_form}
        return render(request, "admin_templates/brand_create.html", context)
    
    def post(self, request):
        brand_form = BrandForm(request.POST)
        if brand_form.is_valid():
            brand_form.save()
            return redirect("brand")
        context = {'form': brand_form}
        return render(request, "admin_templates/brand_create.html", context)
    
class EditBrandView(PermissionRequiredMixin, View):
    permission_required = ["shop.change_brand",]
    def get(self, request, id):
        brand = Brand.objects.get(id=id)
        brand_form = BrandForm(instance=brand)
        context = {'form': brand_form}
        return render(request, "admin_templates/brand_edit.html", context)
    
    def post(self, request, id):
        brand = Brand.objects.get(id=id)
        brand_form = BrandForm(request.POST, instance=brand)
        if brand_form.is_valid():
            brand_form.save()
            return redirect("brand")
        context = {'form': brand_form}
        return render(request, "admin_templates/brand_edit.html", context)

class DeleteBrandView(PermissionRequiredMixin, View):
    permission_required = ["shop.delete_brand",]
    def get(self, request, id):
        brand = Brand.objects.get(id=id)
        brand.delete()
        return redirect("brand")


# DICOUNT CODE
class CodeView(PermissionRequiredMixin, View):
    permission_required = ["shop.view_discountcode",]
    def get(self, request):
        discount_codes = DiscountCode.objects.all().order_by('-start_date')
        context = {"discount_codes": discount_codes}
        return render(request, "admin_templates/discount_code_list.html", context)

class CreateCodeView(PermissionRequiredMixin, View):
    permission_required = ["shop.add_discountcode",]
    def get(self, request):
        code_form = DicountCodeForm()
        context = {'form': code_form}
        return render(request, "admin_templates/discount_code_create.html", context)
    
    def post(self, request):
        code_form = DicountCodeForm(request.POST)
        if code_form.is_valid():
            code_form.save()
            return redirect("code")
        context = {'form': code_form}
        return render(request, "admin_templates/discount_code_create.html", context)

class EditCodeView(PermissionRequiredMixin, View):
    permission_required = ["shop.change_discountcode",]
    def get(self, request, id):
        code = DiscountCode.objects.get(id=id)
        code_form = DicountCodeForm(instance=code)
        context = {'form': code_form}
        return render(request, "admin_templates/discount_code_edit.html", context)
    
    def post(self, request, id):
        code = DiscountCode.objects.get(id=id)
        code_form = DicountCodeForm(request.POST, instance=code)
        if code_form.is_valid():
            code_form.save()
            return redirect("code")
        context = {'form': code_form}
        return render(request, "admin_templates/discount_code_edit.html", context)
    
class ActivateCodeView(PermissionRequiredMixin, View):
    permission_required = ["shop.change_discountcode",]
    def post(self, request, id):
        code = DiscountCode.objects.get(id=id)
        code.is_active = True;
        code.save()
        return redirect('code_edit', id=id)

class DeactivateCodeView(PermissionRequiredMixin, View):
    permission_required = ["shop.change_discountcode",]
    def post(self, request, id):
        code = DiscountCode.objects.get(id=id)
        code.is_active = False;
        code.save()
        return redirect('code_edit', id=id)