from django.shortcuts import render, redirect
from django.views import View

from .models import *
from .forms import *
from django.contrib.auth.models import Group

from django.db.models import Count

from django.contrib.auth import login, logout, update_session_auth_hash
from django.contrib.auth.forms import AuthenticationForm, PasswordChangeForm
from django.contrib.auth.mixins import PermissionRequiredMixin
from django.core.exceptions import PermissionDenied

def is_admin(user):
    return user.groups.filter(name="admin").exists()

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



class ProductListView(View):
    def get(self, request):
        search = request.GET.get("search", "")
        category = request.GET.get("category", "all")
        brand = request.GET.get("brand", "all")
        orderby = request.GET.get("sort", "name")

        products = Product.objects.filter(name__icontains=search).order_by(orderby)
        if category!="all":
            products = products.filter(category__name=category)
        if brand!="all":
            products = products.filter(brand__name=brand)

        categories = Category.objects.all()

        if category!="all":
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
        return redirect("product_list")

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
    permission_required = ["shop.change_address"]
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




class AdminHomeView(PermissionRequiredMixin, View):
    permission_required = ["shop.view_product", "shop.view_order"]
    def get(self, request):
        if not is_admin(request.user):
            raise PermissionDenied("Only for Admin.")
        
        return render(request, "admin_templates/home.html")


# PRODUCT
class ProductView(PermissionRequiredMixin, View):
    permission_required = ["shop.view_product",]
    def get(self, request):
        if not is_admin(request.user):
            raise PermissionDenied("Only for Admin.")
        
        products = Product.objects.all()
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