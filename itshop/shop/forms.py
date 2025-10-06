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