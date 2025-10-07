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

class ProductForm(ModelForm):
    class Meta:
        model = Product
        exclude = ['is_active']
        widgets = {
            "description": Textarea(attrs={"rows": 3}),
            "image": FileInput(attrs={"class": "hidden"})
        }

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