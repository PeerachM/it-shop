from django.db import models
from django.contrib.auth.models import User

class Category(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField(null=True)

class Brand(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField(null=True)

class Product(models.Model):
    class DiscountType(models.TextChoices):
        NONE = "NONE", "ไม่มีส่วนลด"
        PERCENT = "PERCENT", "ลดตามเปอร์เซ็นต์"
        FIXED = "FIXED", "ลดตามจำนวนเงิน"

    category = models.ForeignKey(Category, on_delete=models.SET_NULL, null=True)
    brand = models.ForeignKey(Brand, on_delete=models.SET_NULL, null=True)
    name = models.CharField(max_length=100)
    description = models.TextField(null=True)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    stock = models.PositiveIntegerField(default=0)
    image = models.FileField(upload_to="product_images/")
    discount_type = models.CharField(max_length=8, choices=DiscountType.choices)
    discount_value = models.DecimalField(max_digits=10, decimal_places=2, null=True)
    is_active = models.BooleanField(default=True)

class Customer(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    phone = models.CharField(max_length=20, null=True)
    image = models.FileField(upload_to="customer_images/", blank=True, null=True)
    wishlist = models.ManyToManyField(Product)

class Address(models.Model):
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    full_name = models.CharField(max_length=200)
    phone = models.CharField(max_length=20)
    address = models.TextField()
    district = models.CharField(max_length=50)
    sub_district = models.CharField(max_length=50)
    province = models.CharField(max_length=50)
    postal_code = models.CharField(max_length=10)

class CartItem(models.Model):
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField(default=1)

class DiscountCode(models.Model):
    class CodeType(models.TextChoices):
        PERCENT = "PERCENT", "ลดตามเปอร์เซ็นต์"
        FIXED = "FIXED", "ลดตามจำนวนเงิน"
    code = models.CharField(max_length=50)
    code_type = models.CharField(max_length=8, choices=CodeType.choices)
    value = models.DecimalField(max_digits=10, decimal_places=2)
    start_date = models.DateTimeField()
    end_date = models.DateTimeField(null=True)
    is_active = models.BooleanField(default=True)
    min_order_amount = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    max_discount_amount = models.DecimalField(max_digits=10, decimal_places=2, null=True)
    usage_count = models.PositiveIntegerField(default=0)

class Order(models.Model):
    class OrderStatus(models.TextChoices):
        PENDING = "PENDING", "รอดำเนินการ"
        SHIPPING = "SHIPPING", "กำลังจัดส่ง"
        DELIVERED = "DELIVERED", "จัดส่งสำเร็จ"
        CANCELLED = "CANCELLED", "ยกเลิกคำสั่งซื้อ"
    cutomer = models.OneToOneField(Customer, on_delete=models.CASCADE)
    dicount_code = models.OneToOneField(DiscountCode, on_delete=models.PROTECT, null=True)
    discount_amount = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    shipping_address = models.TextField()
    order_date = models.DateTimeField(auto_now_add=True)
    status = models.CharField(max_length=10, choices=OrderStatus.choices)

class OrderItem(models.Model):
    order = models.OneToOneField(Order, on_delete=models.CASCADE)
    product = models.OneToOneField(Product, on_delete=models.PROTECT)
    quantity = models.PositiveIntegerField(default=1)
    unit_price = models.DecimalField(max_digits=10, decimal_places=2)
    dicount_price = models.DecimalField(max_digits=10, decimal_places=2, default=0)

class Payment(models.Model):
    class PaymentStatus(models.TextChoices):
        PENDING = "PENDING", "รอการตรวจสอบ"
        VERIFIED = "VERIFIED", "ได้รับการยืนยัน"
        REJECTED = "REJECTED", "ปฏิเสธ"
    order = models.OneToOneField(Order, on_delete=models.CASCADE)
    payment_date = models.DateTimeField()
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    slip_image = models.FileField(upload_to="slip_images/")
    status = models.CharField(max_length=10, choices=PaymentStatus.choices)
    