# 🚀 Hızlı Kurulum Kılavuzu

## Adım 1: Docker Kurulumu

1. **Docker Desktop İndirin ve Kurun**

   - Mac: https://www.docker.com/products/docker-desktop
   - Windows: https://www.docker.com/products/docker-desktop
   - Linux: \`sudo apt-get install docker docker-compose\`

2. **Docker'ın Çalıştığını Kontrol Edin**
   \`\`\`bash
   docker --version
   docker-compose --version
   \`\`\`

## Adım 2: Projeyi İndirin

\`\`\`bash
cd /Users/fatihsoymaz/Desktop/coffe
\`\`\`

## Adım 3: Backend'i Başlatın

\`\`\`bash

# Docker container'ları başlat

docker-compose up -d

# Container'ların çalıştığını kontrol edin

docker-compose ps
\`\`\`

Beklenen çıktı:
\`\`\`
NAME IMAGE STATUS
coffee_backend coffe-backend Up
coffee_db postgres:15-alpine Up (healthy)
\`\`\`

## Adım 4: Veritabanını Hazırlayın

\`\`\`bash

# 1. Migrationları uygula

docker-compose exec backend python manage.py migrate

# 2. Admin kullanıcısı oluştur

docker-compose exec backend python manage.py createsuperuser

# Kullanıcı adı: admin

# Email: admin@example.com

# Şifre: (güçlü bir şifre girin)

# 3. Örnek verileri yükle

docker-compose exec backend python manage.py seed_data
\`\`\`

## Adım 5: Frontend'i Başlatın

Yeni bir terminal açın:

\`\`\`bash
cd /Users/fatihsoymaz/Desktop/coffe

# Bağımlılıkları yükle (ilk seferinde)

npm install

# Development server'ı başlat

npm run dev
\`\`\`

## Adım 6: Siteyi Ziyaret Edin

1. **Frontend (Web Sitesi)**: http://localhost:5173
2. **Admin Paneli**: http://localhost:8000/admin
   - Kullanıcı adı: admin
   - Şifre: (oluşturduğunuz şifre)

## 🎯 İlk Ürünü Ekleyin

1. Admin paneline girin: http://localhost:8000/admin
2. Sol menüden **"Ürünler"** → **"Ürün Ekle"** tıklayın
3. Formu doldurun:
   - **Ürün Adı**: Kenya AA
   - **Kategori**: Kahve Çekirdekleri
   - **Fiyat**: 295
   - **Ürün Görseli URL**:
     \`\`\`
     https://images.unsplash.com/photo-1587734195503-904fca47e0e9?w=800&auto=format&fit=crop
     \`\`\`
   - **Menşe**: Kenya
   - **Kavurma Seviyesi**: Medium
   - **Açıklama**:
     \`\`\`
     Kenya'nın yüksek rakımlı bölgelerinden gelen, parlak asitli ve fruity notalarıyla öne çıkan özel kahve.
     \`\`\`
   - **Puan**: 4.8
   - **Stokta**: ✓ İşaretle
   - **Öne Çıkan**: ✓ İşaretle
4. Aşağıda **"Tat Notu"** bölümünde 3 not ekleyin:
   - Çiçeksi
   - Yaban Mersini
   - Limon
5. **"KAYDET"** butonuna tıklayın
6. Frontend'i yenileyin: http://localhost:5173

## ✅ Test Edin

### Backend API Test

\`\`\`bash

# Ürünleri listele

curl http://localhost:8000/api/products/

# Kategorileri listele

curl http://localhost:8000/api/categories/
\`\`\`

### Frontend Test

1. Tarayıcıda http://localhost:5173 açın
2. Kategoriler dropdown'unda kategorileri görmelisiniz
3. Ürünler bölümünde eklediğiniz ürünleri görmelisiniz
4. Ürün kartına tıklayınca detay modal açılmalı

## 🔧 Sorun Giderme

### Docker Container'lar Başlamıyorsa

\`\`\`bash

# Container'ları durdur ve yeniden başlat

docker-compose down
docker-compose up -d --build

# Logları kontrol et

docker-compose logs -f backend
docker-compose logs -f db
\`\`\`

### "ModuleNotFoundError" Hatası

\`\`\`bash

# Container'ı rebuild et

docker-compose down
docker-compose build --no-cache backend
docker-compose up -d
\`\`\`

### Port Çakışması (5173 veya 8000 kullanımda)

\`\`\`bash

# Backend port değiştir (docker-compose.yml)

ports:

- "8001:8000" # 8000 yerine 8001 kullan

# Frontend port otomatik değişir

# Vite başka bir port bulur

\`\`\`

### Veritabanı Bağlantı Hatası

\`\`\`bash

# Database container'ının hazır olmasını bekleyin

docker-compose exec db pg_isready -U coffee_user

# Başarılı ise:

# /var/run/postgresql:5432 - accepting connections

\`\`\`

### Frontend API'ye Bağlanamıyor

1. Backend'in çalıştığından emin olun: http://localhost:8000/api/products/
2. CORS ayarlarını kontrol edin (\`backend/coffee_backend/settings.py\`)
3. Tarayıcı console'unda hata mesajlarına bakın (F12)

## 🛑 Servisleri Durdurma

\`\`\`bash

# Container'ları durdur

docker-compose down

# Frontend'i durdur (Ctrl+C)

# Veritabanını da silmek için

docker-compose down -v
\`\`\`

## 📚 Sonraki Adımlar

1. ✅ Admin panelinden daha fazla ürün ekleyin
2. ✅ Kategorileri özelleştirin
3. ✅ Ürün görsellerini güncelleyin
4. ✅ Frontend tasarımını özelleştirin

## 🆘 Yardım

Sorun yaşıyorsanız:

1. Logları kontrol edin: \`docker-compose logs -f\`
2. README.md dosyasına bakın
3. Issue açın

---

**Başarılar! 🎉**
