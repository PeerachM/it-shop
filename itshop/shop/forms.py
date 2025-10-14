from .models import *
from django.forms import *
from django.contrib.auth.models import User
from django.contrib.auth.forms import UserCreationForm

class CustomUserCreationForm(UserCreationForm):
    email = EmailField(required=True)
    first_name = CharField(required=True)
    last_name = CharField(required=True)
    class Meta:
        model = User
        fields = ['username', 'email', 'first_name', 'last_name', 'password1', 'password2']

class UserForm(ModelForm):
    class Meta:
        model = User
        fields = ['email', 'first_name', 'last_name']

class CustomerForm(ModelForm):
    class Meta:
        model = Customer
        fields = ['phone', 'image']
        widgets = {
            "image": FileInput(attrs={"class": "hidden"})
        }

        def clean_phone(self):
            phone = self.cleaned_data.get("phone")
            if not phone.isdigit():
                raise forms.ValidationError("กรุณากรอกเฉพาะตัวเลขในเบอร์โทรศัพท์")
            if len(phone) < 9 or len(phone) > 10:
                raise forms.ValidationError("เบอร์โทรศัพท์ควรมี 9–10 หลัก")

class AddressForm(ModelForm):
    class Meta:
        model = Address
        exclude = ['customer']
        widgets = {
            "address": Textarea(attrs={"rows": 3}),
        }

    def clean_phone(self):
        phone = self.cleaned_data.get("phone")
        if not phone.isdigit():
            raise forms.ValidationError("กรุณากรอกเฉพาะตัวเลขในเบอร์โทรศัพท์")
        if len(phone) < 9 or len(phone) > 10:
            raise forms.ValidationError("เบอร์โทรศัพท์ต้องมี 9–10 หลัก")
        return phone
    def clean_postal_code(self):
        postal = self.cleaned_data.get("postal_code")
        if not postal.isdigit():
            raise forms.ValidationError("รหัสไปรษณีย์ต้องเป็นตัวเลขเท่านั้น")
        if len(postal) != 5:
            raise forms.ValidationError("รหัสไปรษณีย์ต้องมี 5 หลัก")
        return postal
    
class PaymentForm(ModelForm):
    class Meta:
        model = Payment
        fields = ["amount", "payment_date", "slip_image"]
        widgets = {
            "payment_date": DateTimeInput(attrs={"type": "datetime-local"}),
            "slip_image": FileInput(attrs={"class": "hidden"})
        }

class ProductForm(ModelForm):
    class Meta:
        model = Product
        exclude = ['is_active']
        widgets = {
            "description": Textarea(attrs={"rows": 3}),
            "image": FileInput(attrs={"class": "hidden"})
        }
    def clean_name(self):
        name = self.cleaned_data.get("name")
        if len(name) < 3:
            raise ValidationError("ชื่อสินค้าต้องมีอย่างน้อย 3 ตัวอักษร")
        return name
    def clean_price(self):
        price = self.cleaned_data.get("price")
        if price <= 0:
            raise ValidationError("ราคาสินค้าต้องมากกว่า 0 บาท")
        return price
    def clean_stock(self):
        stock = self.cleaned_data.get("stock")
        if stock and stock < 0:
            raise ValidationError("จำนวนสต็อกต้องไม่ติดลบ")
        return stock
    def clean_discount_value(self):
        discount_value = self.cleaned_data.get("discount_value")
        discount_type = self.cleaned_data.get("discount_type")
        price = self.cleaned_data.get("price")

        if discount_value and discount_value < 0:
            raise ValidationError("ส่วนลดต้องไม่ติดลบ")
        if discount_type != Product.DiscountType.NONE and discount_value <= 0:
            raise ValidationError("ส่วนลดต้องมากกว่า 0")
        if discount_type == Product.DiscountType.PERCENT:
            if discount_value > 100:
                raise ValidationError("ส่วนลดแบบเปอร์เซ็นต์ต้องไม่เกิน 100%")
        elif discount_type == Product.DiscountType.FIXED:
            if price is not None and discount_value > price:
                raise ValidationError("ส่วนลดต้องน้อยกว่าราคาสินค้า")
        return discount_value

class CategoryForm(ModelForm):
    class Meta:
        model = Category
        fields = "__all__"
        widgets = {
            "description": Textarea(attrs={"rows": 2})
        }


class BrandForm(ModelForm):
    class Meta:
        model = Brand
        fields = "__all__"
        widgets = {
            "description": Textarea(attrs={"rows": 2})
        }

class DicountCodeForm(ModelForm):
    class Meta:
        model = DiscountCode
        exclude = ["usage_count", "is_active"]
        widgets = {
            "start_date": DateTimeInput(attrs={"type": "datetime-local"}),
            "end_date": DateTimeInput(attrs={"type": "datetime-local"}),
        }

    def clean_value(self):
        value = self.cleaned_data.get("value")
        code_type = self.cleaned_data.get("code_type")
        if value is None or value <= 0:
            raise forms.ValidationError("ค่าลดต้องมากกว่า 0")
        if code_type == DiscountCode.CodeType.PERCENT and value > 100:
            raise forms.ValidationError("เปอร์เซ็นต์ส่วนลดต้องไม่เกิน 100")
        return value

    def clean_end_date(self):
        start_date = self.cleaned_data.get("start_date")
        end_date = self.cleaned_data.get("end_date")
        if start_date and end_date and start_date >= end_date:
            raise forms.ValidationError("วันหมดอายุต้องมากกว่าวันเริ่ม")
        return end_date

    def clean_max_discount_amount(self):
        max_discount = self.cleaned_data.get("max_discount_amount")
        if max_discount is not None and max_discount < 0:
            raise forms.ValidationError("จำนวนส่วนลดสูงสุดต้องมากกว่า 0")
        return max_discount
    
    def clean_min_order_amount(self):
        min_amount = self.cleaned_data.get("min_order_amount")
        if min_amount is not None and min_amount < 0:
            raise forms.ValidationError("ยอดสั่งซื้อต่ำสุดต้องไม่ติดลบ")
        return min_amount