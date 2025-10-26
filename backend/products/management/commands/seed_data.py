from django.core.management.base import BaseCommand
from django.contrib.auth import get_user_model
from products.models import Category, Product, TasteNote

User = get_user_model()


class Command(BaseCommand):
    help = 'Veritabanına örnek veri ve admin kullanıcısı ekler'

    def handle(self, *args, **kwargs):
        # Admin kullanıcısı oluştur
        self.stdout.write('Admin kullanıcısı kontrol ediliyor...')
        
        if not User.objects.filter(username='admin').exists():
            User.objects.create_superuser(
                username='admin',
                email='admin@coffee.com',
                password='admin123'
            )
            self.stdout.write(self.style.SUCCESS('✅ Admin kullanıcısı oluşturuldu (username: admin, password: admin123)'))
        else:
            self.stdout.write(self.style.WARNING('⚠️  Admin kullanıcısı zaten mevcut'))
        
        self.stdout.write('Kategoriler oluşturuluyor...')
        
        # Kategorileri oluştur
        categories_data = [
            {'id': 'all', 'name': 'Tümü', 'icon': '☕', 'description': 'Tüm ürünler', 'order': 0},
            {'id': 'beans', 'name': 'Kahve Çekirdekleri', 'icon': '🫘', 'description': 'Taze kavrum çekirdekler', 'order': 1},
            {'id': 'ground', 'name': 'Öğütülmüş Kahve', 'icon': '🌰', 'description': 'Hazır öğütülmüş', 'order': 2},
            {'id': 'capsules', 'name': 'Kapsül Kahve', 'icon': '🔵', 'description': 'Pratik kapsüller', 'order': 3},
            {'id': 'equipment', 'name': 'Ekipmanlar', 'icon': '⚙️', 'description': 'Kahve makineleri', 'order': 4},
            {'id': 'accessories', 'name': 'Aksesuarlar', 'icon': '🎁', 'description': 'Kahve aksesuarları', 'order': 5},
        ]
        
        for cat_data in categories_data:
            Category.objects.get_or_create(
                id=cat_data['id'],
                defaults={
                    'name': cat_data['name'],
                    'icon': cat_data['icon'],
                    'description': cat_data['description'],
                    'order': cat_data['order']
                }
            )
        
        self.stdout.write(self.style.SUCCESS(f'{len(categories_data)} kategori oluşturuldu'))
        
        # Örnek ürünler
        self.stdout.write('Ürünler oluşturuluyor...')
        
        products_data = [
            {
                'name': 'Ethiopia Yirgacheffe',
                'category_id': 'beans',
                'price': 285,
                'image': 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?w=800&auto=format&fit=crop',
                'origin': 'Etiyopya',
                'roast': 'Light',
                'description': 'Etiyopyanın en prestijli bölgesinden, çiçeksi ve narenciye notalarıyla öne çıkan özel kahve.',
                'rating': 4.9,
                'in_stock': True,
                'featured': True,
                'notes': ['Çiçeksi', 'Narenciye', 'Bergamot']
            },
            {
                'name': 'Colombia Supremo',
                'category_id': 'beans',
                'price': 265,
                'image': 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=800&auto=format&fit=crop',
                'origin': 'Kolombiya',
                'roast': 'Medium',
                'description': 'Kolombiya\'nın en yüksek kalite standardı, dengeli asitlik ve zengin lezzet profili.',
                'rating': 4.8,
                'in_stock': True,
                'featured': True,
                'notes': ['Karamel', 'Fındık', 'Çikolata']
            },
            {
                'name': 'Brazil Santos',
                'category_id': 'beans',
                'price': 245,
                'image': 'https://images.unsplash.com/photo-1511920170033-f8396924c348?w=800&auto=format&fit=crop',
                'origin': 'Brezilya',
                'roast': 'Medium-Dark',
                'description': 'Düşük asitli, yumuşak ve kremalı doku. Espresso için mükemmel seçim.',
                'rating': 4.7,
                'in_stock': True,
                'featured': False,
                'notes': ['Çikolata', 'Badem', 'Tatlı']
            },
        ]
        
        for prod_data in products_data:
            notes = prod_data.pop('notes', [])
            product, created = Product.objects.get_or_create(
                name=prod_data['name'],
                defaults=prod_data
            )
            
            if created:
                for index, note in enumerate(notes):
                    TasteNote.objects.create(
                        product=product,
                        note=note,
                        order=index
                    )
        
        self.stdout.write(self.style.SUCCESS(f'{len(products_data)} ürün oluşturuldu'))
        self.stdout.write(self.style.SUCCESS('Veri ekleme tamamlandı!'))

