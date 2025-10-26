from django.db import models
from django.core.validators import MinValueValidator, MaxValueValidator


class Category(models.Model):
    """Ürün Kategorileri"""
    
    CATEGORY_CHOICES = [
        ('all', 'Tümü'),
        ('beans', 'Kahve Çekirdekleri'),
        ('ground', 'Öğütülmüş Kahve'),
        ('capsules', 'Kapsül Kahve'),
        ('equipment', 'Ekipmanlar'),
        ('accessories', 'Aksesuarlar'),
    ]
    
    id = models.CharField(max_length=50, primary_key=True, choices=CATEGORY_CHOICES)
    name = models.CharField(max_length=100, verbose_name='Kategori Adı')
    icon = models.CharField(max_length=10, verbose_name='İkon', help_text='Emoji veya karakter')
    description = models.TextField(blank=True, verbose_name='Açıklama')
    order = models.IntegerField(default=0, verbose_name='Sıralama')
    
    class Meta:
        verbose_name = 'Kategori'
        verbose_name_plural = 'Kategoriler'
        ordering = ['order', 'name']
    
    def __str__(self):
        return self.name


class Product(models.Model):
    """Kahve Ürünleri"""
    
    ROAST_CHOICES = [
        ('Light', 'Açık Kavrum'),
        ('Medium', 'Orta Kavrum'),
        ('Medium-Dark', 'Orta-Koyu Kavrum'),
        ('Dark', 'Koyu Kavrum'),
    ]
    
    name = models.CharField(max_length=200, verbose_name='Ürün Adı')
    category = models.ForeignKey(
        Category, 
        on_delete=models.CASCADE, 
        related_name='products',
        verbose_name='Kategori'
    )
    price = models.DecimalField(
        max_digits=10, 
        decimal_places=2, 
        verbose_name='Fiyat (₺)',
        validators=[MinValueValidator(0)]
    )
    image = models.ImageField(upload_to='products/', verbose_name='Ürün Görseli', blank=True, null=True)
    origin = models.CharField(max_length=100, verbose_name='Menşe', blank=True)
    roast = models.CharField(
        max_length=20, 
        choices=ROAST_CHOICES, 
        verbose_name='Kavurma Seviyesi',
        blank=True
    )
    description = models.TextField(verbose_name='Açıklama')
    rating = models.DecimalField(
        max_digits=2, 
        decimal_places=1, 
        verbose_name='Puan',
        validators=[MinValueValidator(0), MaxValueValidator(5)],
        default=4.5
    )
    in_stock = models.BooleanField(default=True, verbose_name='Stokta')
    featured = models.BooleanField(default=False, verbose_name='Öne Çıkan')
    
    created_at = models.DateTimeField(auto_now_add=True, verbose_name='Oluşturma Tarihi')
    updated_at = models.DateTimeField(auto_now=True, verbose_name='Güncellenme Tarihi')
    
    class Meta:
        verbose_name = 'Ürün'
        verbose_name_plural = 'Ürünler'
        ordering = ['-featured', '-created_at']
    
    def __str__(self):
        return self.name


class TasteNote(models.Model):
    """Tat Notları"""
    
    product = models.ForeignKey(
        Product, 
        on_delete=models.CASCADE, 
        related_name='notes',
        verbose_name='Ürün'
    )
    note = models.CharField(max_length=50, verbose_name='Tat Notu')
    order = models.IntegerField(default=0, verbose_name='Sıra')
    
    class Meta:
        verbose_name = 'Tat Notu'
        verbose_name_plural = 'Tat Notları'
        ordering = ['order']
    
    def __str__(self):
        return f"{self.product.name} - {self.note}"

