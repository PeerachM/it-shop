from .models import *
from django.forms import *
from django.contrib.auth.models import User
from django.contrib.auth.forms import UserCreationForm

class CustomUserCreationForm(UserCreationForm):
    class Meta:
        model = User
        fields = ['username', 'email', 'first_name', 'last_name', 'password1', 'password2']

class ProductForm(ModelForm):
    class Meta:
        model = Product
        fields = "__all__"
        widgets = {
            "category": Select(attrs={"class": "border border-gray-200 p-3 w-full rounded-md"}),
            "brand": Select(attrs={"class": "border border-gray-200 p-3 w-full rounded-md"}),
            "name": TextInput(attrs={"class": "border border-gray-200 p-3 w-full rounded-md"}),
            "description": Textarea(attrs={"rows": 2, "class": "border border-gray-200 p-3 w-full rounded-md"}),
            "price": NumberInput(attrs={"class": "border border-gray-200 p-3 w-full rounded-md"}),
            "stock": NumberInput(attrs={"class": "border border-gray-200 p-3 w-full rounded-md"}),
            "image": FileInput(attrs={"class": "hidden"}),
            "discount_type": Select(attrs={"class": "border border-gray-200 p-3 w-full rounded-md"}),
            "discount_value": NumberInput(attrs={"class": "border border-gray-200 p-3 w-full rounded-md"}),
            "is_active": CheckboxInput(attrs={"class": "border border-gray-200 p-3 w-full rounded-md"}),
        }

class CategoryForm(ModelForm):
    class Meta:
        model = Category
        fields = "__all__"
        widgets = {
            "name": TextInput(attrs={
                "class": "border border-gray-200 p-3 w-full rounded-md"
                }),
            "description": Textarea(attrs={
                    "rows": 2,
                    "class": "border border-gray-200 p-3 w-full rounded-md"
                }),
        }


class BrandForm(ModelForm):
    class Meta:
        model = Brand
        fields = "__all__"
        widgets = {
            "name": TextInput(attrs={
                "class": "border border-gray-200 p-3 w-full rounded-md"
                }),
            "description": Textarea(attrs={
                    "rows": 2,
                    "class": "border border-gray-200 p-3 w-full rounded-md"
                }),
        }