#!/bin/bash

echo "🚀 Coffee Paradise Başlatılıyor..."
echo ""

# Backend'i kontrol et ve başlat
echo "📦 Docker container'lar başlatılıyor..."
sudo docker compose up -d

echo ""
echo "⏳ Veritabanının hazır olması bekleniyor..."
sleep 5

# Migration kontrolü
echo ""
echo "🔧 Veritabanı migrationları kontrol ediliyor..."
docker compose exec -T backend python manage.py migrate

# Superuser var mı kontrol et
echo ""
echo "👤 Admin kullanıcısı kontrolü..."
sudo docker compose exec -T backend python manage.py shell -c "
from django.contrib.auth import get_user_model;
User = get_user_model();
if not User.objects.filter(username='admin').exists():
    print('Admin kullanıcısı bulunamadı. Lütfen oluşturun:');
    print('docker-compose exec backend python manage.py createsuperuser')
else:
    print('✓ Admin kullanıcısı mevcut')
"

# Seed data kontrolü
echo ""
echo "🌱 Örnek veri kontrolü..."
sudo docker compose exec -T backend python manage.py shell -c "
from products.models import Product;
if Product.objects.count() == 0:
    print('Ürün bulunamadı. Örnek veriler yükleniyor...');
    import os;
    os.system('python manage.py seed_data')
else:
    print('✓ Ürünler mevcut (' + str(Product.objects.count()) + ' adet)')
"

echo ""
echo "✅ Backend hazır!"
echo ""
echo "📍 Erişim Adresleri:"
echo "   - Admin Paneli: http://localhost:8000/admin"
echo "   - API:          http://localhost:8000/api/products/"
echo ""
echo "🎨 Frontend'i başlatmak için:"
echo "   npm install  (ilk seferinde)"
echo "   npm run dev"
echo ""
echo "📚 Detaylı kurulum için: SETUP.md"
echo ""

