from django.contrib import admin
from django.utils.html import format_html
from .models import Category, Product, TasteNote


class TasteNoteInline(admin.TabularInline):
    """Ürün detayında tat notlarını göster"""
    model = TasteNote
    extra = 1
    fields = ['note', 'order']


@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    """Kategori Admin Paneli"""
    list_display = ['name', 'icon', 'id', 'order', 'product_count']
    list_editable = ['order']
    search_fields = ['name', 'description']
    ordering = ['order', 'name']
    
    def product_count(self, obj):
        count = obj.products.count()
        return format_html(
            '<span style="background: #4CAF50; color: white; padding: 3px 10px; '
            'border-radius: 10px; font-weight: bold;">{}</span>',
            count
        )
    product_count.short_description = 'Ürün Sayısı'


@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    """Ürün Admin Paneli"""
    list_display = [
        'image_preview', 'name', 'category', 'price_formatted', 
        'rating_stars', 'in_stock', 'featured', 'created_at'
    ]
    list_filter = ['category', 'in_stock', 'featured', 'roast', 'created_at']
    search_fields = ['name', 'description', 'origin']
    list_editable = ['in_stock', 'featured']
    readonly_fields = ['image_preview_large', 'created_at', 'updated_at']
    inlines = [TasteNoteInline]
    actions = ['mark_in_stock', 'mark_out_of_stock', 'mark_as_featured', 'unmark_as_featured']
    
    fieldsets = (
        ('Genel Bilgiler', {
            'fields': ('name', 'category', 'description')
        }),
        ('Fiyat ve Stok', {
            'fields': ('price', 'in_stock', 'featured')
        }),
        ('Ürün Detayları', {
            'fields': ('origin', 'roast', 'rating')
        }),
        ('Görsel', {
            'fields': ('image', 'image_preview_large')
        }),
        ('Tarih Bilgileri', {
            'fields': ('created_at', 'updated_at'),
            'classes': ('collapse',)
        }),
    )
    
    def image_preview(self, obj):
        if obj.image:
            return format_html(
                '<img src="{}" style="width: 50px; height: 50px; '
                'object-fit: cover; border-radius: 8px;" />',
                obj.image
            )
        return '-'
    image_preview.short_description = 'Görsel'
    
    def image_preview_large(self, obj):
        if obj.image:
            return format_html(
                '<img src="{}" style="max-width: 300px; max-height: 300px; '
                'border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.1);" />',
                obj.image
            )
        return '-'
    image_preview_large.short_description = 'Ürün Görseli'
    
    def price_formatted(self, obj):
        return format_html(
            '<span style="color: #6F4E37; font-weight: bold; font-size: 14px;">{} ₺</span>',
            obj.price
        )
    price_formatted.short_description = 'Fiyat'
    
    def rating_stars(self, obj):
        full_stars = int(obj.rating)
        stars = '⭐' * full_stars
        return format_html(
            '<span style="font-size: 16px;">{}</span> '
            '<span style="color: #666; margin-left: 5px;">{}</span>',
            stars, obj.rating
        )
    rating_stars.short_description = 'Puan'
    
    def mark_in_stock(self, request, queryset):
        """Seçili ürünleri stokta olarak işaretle"""
        updated = queryset.update(in_stock=True)
        self.message_user(request, f'{updated} ürün stokta olarak işaretlendi.')
    mark_in_stock.short_description = '✓ Seçilenleri stokta olarak işaretle'
    
    def mark_out_of_stock(self, request, queryset):
        """Seçili ürünleri stoktan çıkar"""
        updated = queryset.update(in_stock=False)
        self.message_user(request, f'{updated} ürün stoktan çıkarıldı.')
    mark_out_of_stock.short_description = '✗ Seçilenleri stoktan çıkar'
    
    def mark_as_featured(self, request, queryset):
        """Seçili ürünleri öne çıkan olarak işaretle"""
        updated = queryset.update(featured=True)
        self.message_user(request, f'{updated} ürün öne çıkan olarak işaretlendi.')
    mark_as_featured.short_description = '⭐ Seçilenleri öne çıkan yap'
    
    def unmark_as_featured(self, request, queryset):
        """Seçili ürünleri öne çıkandan kaldır"""
        updated = queryset.update(featured=False)
        self.message_user(request, f'{updated} ürün öne çıkandan kaldırıldı.')
    unmark_as_featured.short_description = '☆ Seçilenleri öne çıkandan kaldır'


@admin.register(TasteNote)
class TasteNoteAdmin(admin.ModelAdmin):
    """Tat Notu Admin Paneli"""
    list_display = ['product', 'note', 'order']
    list_filter = ['product__category']
    search_fields = ['product__name', 'note']
    list_editable = ['order']
    ordering = ['product', 'order']

