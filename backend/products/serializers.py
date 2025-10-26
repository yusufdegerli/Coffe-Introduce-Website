from rest_framework import serializers
from .models import Category, Product, TasteNote


class TasteNoteSerializer(serializers.ModelSerializer):
    """Tat Notu Serializer"""
    
    class Meta:
        model = TasteNote
        fields = ['note']


class CategorySerializer(serializers.ModelSerializer):
    """Kategori Serializer"""
    
    class Meta:
        model = Category
        fields = ['id', 'name', 'icon', 'description']


class ProductListSerializer(serializers.ModelSerializer):
    """Ürün Liste Serializer (Özet bilgiler)"""
    
    notes = serializers.SerializerMethodField()
    image = serializers.SerializerMethodField()
    
    class Meta:
        model = Product
        fields = [
            'id', 'name', 'category', 'price', 'image', 
            'origin', 'roast', 'description', 'rating', 
            'in_stock', 'notes'
        ]
    
    def get_notes(self, obj):
        # İlk 3 tat notunu döndür
        notes = obj.notes.all()[:3]
        return [note.note for note in notes]
    
    def get_image(self, obj):
        if obj.image:
            request = self.context.get('request')
            if request:
                return request.build_absolute_uri(obj.image.url)
            return obj.image.url
        return None


class ProductDetailSerializer(serializers.ModelSerializer):
    """Ürün Detay Serializer (Tüm bilgiler)"""
    
    notes = TasteNoteSerializer(many=True, read_only=True)
    category_name = serializers.CharField(source='category.name', read_only=True)
    image = serializers.SerializerMethodField()
    
    class Meta:
        model = Product
        fields = [
            'id', 'name', 'category', 'category_name', 'price', 
            'image', 'origin', 'roast', 'description', 'rating', 
            'in_stock', 'featured', 'notes', 'created_at', 'updated_at'
        ]
    
    def get_image(self, obj):
        if obj.image:
            request = self.context.get('request')
            if request:
                return request.build_absolute_uri(obj.image.url)
            return obj.image.url
        return None


class ProductCreateUpdateSerializer(serializers.ModelSerializer):
    """Ürün Oluşturma/Güncelleme Serializer"""
    
    notes = serializers.ListField(
        child=serializers.CharField(max_length=50),
        required=False,
        write_only=True
    )
    
    class Meta:
        model = Product
        fields = [
            'name', 'category', 'price', 'image', 'origin', 
            'roast', 'description', 'rating', 'in_stock', 
            'featured', 'notes'
        ]
    
    def create(self, validated_data):
        notes_data = validated_data.pop('notes', [])
        product = Product.objects.create(**validated_data)
        
        # Tat notlarını oluştur
        for index, note in enumerate(notes_data):
            TasteNote.objects.create(
                product=product,
                note=note,
                order=index
            )
        
        return product
    
    def update(self, instance, validated_data):
        notes_data = validated_data.pop('notes', None)
        
        # Ürünü güncelle
        for attr, value in validated_data.items():
            setattr(instance, attr, value)
        instance.save()
        
        # Tat notlarını güncelle
        if notes_data is not None:
            instance.notes.all().delete()
            for index, note in enumerate(notes_data):
                TasteNote.objects.create(
                    product=instance,
                    note=note,
                    order=index
                )
        
        return instance

