from django.urls import path
from . import views

urlpatterns = [
    path("register/", views.RegisterView.as_view(), name="register"),
    path("", views.AdminHomeView.as_view(), name="home"),

    path("product/", views.ProductView.as_view(), name="product"),
    path("product/create/", views.CreateProductView.as_view(), name="product_create"),
    path("product/edit/<int:id>", views.EditProductView.as_view(), name="product_edit"),

    path("category/", views.CategoryView.as_view(), name="category"),
    path("category/create/", views.CreateCategoryView.as_view(), name="category_create"),
    path("category/edit/<int:id>", views.EditCategoryView.as_view(), name="category_edit"),
    path("category/delete/<int:id>/", views.DeleteCategoryView.as_view(), name="category_delete"),

    path("brand/", views.BrandView.as_view(), name="brand"),
    path("brand/create/", views.CreateBrandView.as_view(), name="brand_create"),
    path("brand/edit/<int:id>", views.EditBrandView.as_view(), name="brand_edit"),
    path("brand/delete/<int:id>/", views.DeleteBrandView.as_view(), name="brand_delete"),
]
