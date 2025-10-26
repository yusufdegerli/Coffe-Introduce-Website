from rest_framework import viewsets, filters
from rest_framework.decorators import action
from rest_framework.response import Response
from django_filters.rest_framework import DjangoFilterBackend
from .models import Category, Product
from .serializers import (
    CategorySerializer, 
    ProductListSerializer, 
    ProductDetailSerializer,
    ProductCreateUpdateSerializer
)


class CategoryViewSet(viewsets.ReadOnlyModelViewSet):
    """
    Kategori API
    
    list: Tüm kategorileri listele
    retrieve: Tek bir kategori detayı
    """
    queryset = Category.objects.all()
    serializer_class = CategorySerializer


class ProductViewSet(viewsets.ModelViewSet):
    """
    Ürün API
    
    list: Tüm ürünleri listele (filtreleme destekli)
    retrieve: Tek bir ürün detayı
    create: Yeni ürün oluştur
    update: Ürün güncelle
    partial_update: Ürün kısmi güncelleme
    destroy: Ürün sil
    """
    queryset = Product.objects.select_related('category').prefetch_related('notes').all()
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['category', 'in_stock', 'featured', 'roast']
    search_fields = ['name', 'description', 'origin']
    ordering_fields = ['price', 'rating', 'created_at', 'name']
    ordering = ['-featured', '-created_at']
    
    def get_serializer_class(self):
        """Action'a göre serializer seç"""
        if self.action == 'retrieve':
            return ProductDetailSerializer
        elif self.action in ['create', 'update', 'partial_update']:
            return ProductCreateUpdateSerializer
        return ProductListSerializer
    
    def get_serializer_context(self):
        """Request context'i serializer'a ekle"""
        context = super().get_serializer_context()
        context['request'] = self.request
        return context
    
    @action(detail=False, methods=['get'])
    def by_category(self, request):
        """Kategoriye göre ürünleri getir"""
        category_id = request.query_params.get('category', 'all')
        
        if category_id == 'all':
            products = self.get_queryset()
        else:
            products = self.get_queryset().filter(category_id=category_id)
        
        serializer = self.get_serializer(products, many=True)
        return Response(serializer.data)
    
    @action(detail=False, methods=['get'])
    def featured(self, request):
        """Öne çıkan ürünleri getir"""
        products = self.get_queryset().filter(featured=True)
        serializer = self.get_serializer(products, many=True)
        return Response(serializer.data)
    
    @action(detail=False, methods=['get'])
    def in_stock(self, request):
        """Stokta olan ürünleri getir"""
        products = self.get_queryset().filter(in_stock=True)
        serializer = self.get_serializer(products, many=True)
        return Response(serializer.data)

