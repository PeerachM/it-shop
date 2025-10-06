from django.urls import path
from . import views

urlpatterns = [
    path("register/", views.RegisterView.as_view(), name="register"),
    path("login/", views.LoginView.as_view(), name="login"),
    path("logout/", views.LogoutView.as_view(), name="logout"),

    path("", views.CutomerHomeView.as_view(), name="customer_home"),
    path("profile/", views.ProfileView.as_view(), name="profile"),


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
