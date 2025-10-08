from django.urls import path
from . import views

urlpatterns = [
    path("register/", views.RegisterView.as_view(), name="register"),
    path("login/", views.LoginView.as_view(), name="login"),
    path("logout/", views.LogoutView.as_view(), name="logout"),

    path("product/", views.ProductListView.as_view(), name="product_list"),
    path("product/<int:id>", views.ProductDetailView.as_view(), name="product_detail"),

    path("profile/", views.EditProfileView.as_view(), name="profile"),
    path("profile/change-password/", views.ChangePasswordView.as_view(), name="change_password"),

    path("address/", views.AddressView.as_view(), name="address"),
    path("address/create", views.CreateAddressView.as_view(), name="address_create"),
    path("address/<int:id>/edit", views.EditAddressView.as_view(), name="address_edit"),
    path("address/<int:id>/delete", views.DeleteAddressView.as_view(), name="address_delete"),



    path("management/", views.AdminHomeView.as_view(), name="admin_home"),

    path("management/product/", views.ProductView.as_view(), name="product"),
    path("management/product/create/", views.CreateProductView.as_view(), name="product_create"),
    path("management/product/<int:id>/edit/", views.EditProductView.as_view(), name="product_edit"),
    path("management/product/<int:id>/activate/", views.ActivateProductView.as_view(), name="product_activate"),
    path("management/product/<int:id>/deactivate/", views.DeactivateProductView.as_view(), name="product_deactivate"),

    path("management/category/", views.CategoryView.as_view(), name="category"),
    path("management/category/create/", views.CreateCategoryView.as_view(), name="category_create"),
    path("management/category/<int:id>/edit/", views.EditCategoryView.as_view(), name="category_edit"),
    path("management/category/<int:id>/delete/", views.DeleteCategoryView.as_view(), name="category_delete"),

    path("management/brand/", views.BrandView.as_view(), name="brand"),
    path("management/brand/create/", views.CreateBrandView.as_view(), name="brand_create"),
    path("management/brand/<int:id>/edit/", views.EditBrandView.as_view(), name="brand_edit"),
    path("management/brand/<int:id>/delete/", views.DeleteBrandView.as_view(), name="brand_delete"),
]
