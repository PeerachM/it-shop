from django.urls import path
from . import views

urlpatterns = [
    path("register/", views.RegisterView.as_view(), name="register"),
    path("", views.AdminHomeView.as_view(), name="home"),

    path("product/", views.ProductView.as_view(), name="product"),
    path("product/create/", views.CreateProductView.as_view(), name="product_create"),
    path("product/<int:id>/edit/", views.EditProductView.as_view(), name="product_edit"),
    path("product/<int:id>/activate/", views.ActivateProductView.as_view(), name="product_activate"),
    path("product/<int:id>/deactivate/", views.DeactivateProductView.as_view(), name="product_deactivate"),

    path("category/", views.CategoryView.as_view(), name="category"),
    path("category/create/", views.CreateCategoryView.as_view(), name="category_create"),
    path("category/<int:id>/edit/", views.EditCategoryView.as_view(), name="category_edit"),
    path("category/<int:id>/delete/", views.DeleteCategoryView.as_view(), name="category_delete"),

    path("brand/", views.BrandView.as_view(), name="brand"),
    path("brand/create/", views.CreateBrandView.as_view(), name="brand_create"),
    path("brand/<int:id>/edit/", views.EditBrandView.as_view(), name="brand_edit"),
    path("brand/<int:id>/delete/", views.DeleteBrandView.as_view(), name="brand_delete"),
]
