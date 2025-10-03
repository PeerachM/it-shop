from django.shortcuts import render, redirect
from django.views import View

from .models import *
from .forms import *

from django.db.models import Count

class RegisterView(View):
    def get(self, request):
        reg_form = CustomUserCreationForm()
        context = {'form': reg_form}
        return render(request, "auth_templates/register.html", context)

    def post(self, request):
        return redirect('home')

class AdminHomeView(View):
    def get(self, request):
        return render(request, "admin_templates/home.html")


# PRODUCT
class ProductView(View):
    def get(self, request):
        products = Product.objects.all()
        context = {"products": products}
        return render(request, "admin_templates/product_list.html", context)

class CreateProductView(View):
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
        print(product_form.errors)
        return render(request, "admin_templates/product_create.html", context)
    
class EditProductView(View):
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
        print(product_form.errors)
        return render(request, "admin_templates/product_edit.html", context)


# CATEGORY
class CategoryView(View):
    def get(self, request):
        categories = Category.objects.annotate(product_count=Count('product'))
        context = {"categories": categories}
        return render(request, "admin_templates/category_list.html", context)

class CreateCategoryView(View):
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
    
class EditCategoryView(View):
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

class DeleteCategoryView(View):
    def get(self, request, id):
        category = Category.objects.get(id=id)
        category.delete()
        return redirect("category")


# BRAND
class BrandView(View):
    def get(self, request):
        brands = Brand.objects.annotate(product_count=Count('product'))
        context = {"brands": brands}
        return render(request, "admin_templates/brand_list.html", context)

class CreateBrandView(View):
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
    
class EditBrandView(View):
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

class DeleteBrandView(View):
    def get(self, request, id):
        brand = Brand.objects.get(id=id)
        brand.delete()
        return redirect("brand")