# ☕ Coffee Paradise - Kahve Ürün Bilgilendirme Platformu

Modern, profesyonel ve tamamen Dockerize edilmiş kahve ürün tanıtım platformu. Django REST Framework backend, React + Vite frontend ve Nginx ile HTTPS desteği.

**Not:** Bu platform sadece bilgilendirme amaçlıdır, e-ticaret özelliği içermez. Ziyaretçiler ürünleri inceleyip bilgi alabilir.

![Django](https://img.shields.io/badge/Django-4.2.8-green)
![React](https://img.shields.io/badge/React-18.3.1-blue)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue)
![Nginx](https://img.shields.io/badge/Nginx-Alpine-green)
![Docker](https://img.shields.io/badge/Docker-Compose-blue)

## 🚀 Platform Özellikleri

Bu platform, kahve ürünlerini sergilemek ve müşterilere bilgi vermek için tasarlanmıştır. Doğrudan satış yerine, ziyaretçiler ürünleri inceleyip iletişim formu üzerinden bilgi alabilir.

### ✨ Frontend (React + Vite + Nginx)

- ✅ Modern ve responsive tasarım
- ✅ HTTPS desteği (self-signed SSL)
- ✅ Nginx ile optimize edilmiş servis
- ✅ Ürün kategorileri (dropdown navigation)
- ✅ Detaylı ürün görünümü (modal)
- ✅ Filtreleme ve arama
- ✅ İletişim formu (bilgi alma)
- ✅ Loading ve error state'leri
- ✅ Animasyonlar ve geçişler
- ✅ E-commerce özelliği yok (sepet, ödeme vs. yok)

### 🔧 Backend (Django + DRF + PostgreSQL)

- ✅ Django REST Framework API
- ✅ PostgreSQL veritabanı
- ✅ Güçlü ve özelleştirilmiş Admin Paneli
- ✅ Ürün, kategori ve tat notu yönetimi
- ✅ **Resim upload sistemi** (bilgisayardan dosya yükleme)
- ✅ **Toplu stok yönetimi** (bulk actions)
- ✅ Filtreleme, arama ve sıralama
- ✅ CORS desteği
- ✅ Pagination

### 🐳 DevOps

- ✅ **Tam Docker containerization**
- ✅ **Makefile ile tek komut yönetimi**
- ✅ Docker Compose orchestration
- ✅ Multi-stage build (optimize edilmiş image'ler)
- ✅ Volume yönetimi (data persistence)
- ✅ Health checks
- ✅ Hot-reload development

## 📋 Gereksinimler

- **Docker Desktop** (20.10+)
- **Docker Compose** (2.0+)
- **Make** (genellikle macOS/Linux'ta yüklü)

**Not**: Node.js veya Python yüklemenize gerek yok! Her şey Docker içinde çalışıyor.

## 🎯 Hızlı Başlangıç

### 1️⃣ İlk Kurulum (Tek Komut!)

```bash
# Projeyi klonlayın
git clone <repository-url>
cd coffe

# Tüm sistemi kur ve başlat
make fresh
```

Bu tek komut:

- ✅ SSL sertifikası oluşturur
- ✅ Dependencies yükler
- ✅ Docker build yapar
- ✅ Servisleri başlatır
- ✅ Database migration çalıştırır
- ✅ Örnek veri yükler
- ✅ Admin kullanıcısı oluşturur

### 2️⃣ Sistemi Kullan

Kurulum tamamlandığında sistem otomatik olarak admin kullanıcısı oluşturur:

- **Frontend**: https://localhost
- **Admin Paneli**: https://localhost/admin
- **API**: https://localhost/api/products/

**Otomatik Oluşturulan Admin Giriş Bilgileri:**

- Kullanıcı: `admin`
- Şifre: `admin123`

**Not:** `make up` veya `make fresh` komutu çalıştırıldığında admin kullanıcısı otomatik olarak oluşturulur.

### 3️⃣ SSL Uyarısı

İlk açılışta tarayıcı güvenlik uyarısı verecek (self-signed sertifika):

- Chrome/Edge: "Advanced" → "Proceed to localhost"
- Firefox: "Advanced" → "Accept the Risk and Continue"
- Safari: "Show Details" → "Visit this website"

## 📚 Makefile Komutları

### 🏃 Temel Komutlar

```bash
make help       # Tüm komutları göster
make up         # Sistemi başlat
make down       # Sistemi durdur
make restart    # Yeniden başlat
make logs       # Logları izle
make status     # Durum kontrol
```

### 🗄️ Database Komutları

```bash
make migrate           # Migration çalıştır
make makemigrations    # Migration oluştur
make seed             # Örnek veri yükle
make superuser        # Admin kullanıcı oluştur
make db-backup        # Backup al
make db-restore file=backup.sql  # Restore et
```

### 🐚 Shell & Debug

```bash
make shell            # Django shell
make backend-shell    # Backend container
make frontend-shell   # Frontend container
make db-shell         # PostgreSQL shell
make check           # Sistem kontrolü
make health          # Sağlık kontrolü
```

### 🛠️ Build & Development

```bash
make build            # Tüm servisleri build et
make rebuild          # Cache'siz rebuild
make build-frontend   # Sadece frontend
make build-backend    # Sadece backend
make dev             # Development mode (hot-reload)
```

### 🧹 Temizlik

```bash
make clean           # Her şeyi temizle
make clean-volumes   # Sadece volumes
make clean-images    # Sadece images
make clean-cache     # Build cache
```

### ⚡ Hızlı İşlemler

```bash
make fresh           # Sıfırdan kurulum
make demo            # Demo verilerle başlat
make reset           # Sıfırla ve yeniden kur
make update          # Sistemi güncelle
make quick           # Hızlı başlat (build olmadan)
```

## 🎨 Admin Paneli Özellikleri

### 📊 Ürün Yönetimi

Admin panelinde şunları yapabilirsiniz:

1. **Liste Görünümünden Hızlı Düzenleme**

   - Stok durumunu checkbox'tan değiştir
   - Öne çıkan ürünleri işaretle
   - Direkt kaydet!

2. **Toplu İşlemler (Bulk Actions)**

   - Birden fazla ürün seçin
   - ✓ Seçilenleri stokta işaretle
   - ✗ Seçilenleri stoktan çıkar
   - ⭐ Seçilenleri öne çıkan yap
   - ☆ Seçilenleri öne çıkandan kaldır

3. **Resim Upload**

   - Bilgisayardan direkt resim yükleyin
   - Desteklenen formatlar: JPG, PNG, WEBP, GIF
   - Otomatik önizleme

4. **Filtreleme ve Arama**
   - Kategoriye göre filtrele
   - Stok durumuna göre filtrele
   - Kavurma seviyesine göre filtrele
   - İsim, açıklama, menşe'de ara

## 🔧 API Dokümantasyonu

### Endpoints

#### Kategoriler

```http
GET /api/categories/              # Tüm kategoriler
GET /api/categories/{id}/         # Tek kategori
```

#### Ürünler

```http
GET  /api/products/               # Tüm ürünler
GET  /api/products/{id}/          # Tek ürün
POST /api/products/               # Yeni ürün (admin)
PUT  /api/products/{id}/          # Ürün güncelle (admin)
DELETE /api/products/{id}/        # Ürün sil (admin)

# Özel endpoints
GET /api/products/by_category/?category={id}  # Kategoriye göre
GET /api/products/featured/                   # Öne çıkanlar
GET /api/products/in_stock/                   # Stokta olanlar
```

#### Filtreleme

```bash
# Kategori
/api/products/?category=beans

# Stok durumu
/api/products/?in_stock=true

# Kavurma seviyesi
/api/products/?roast=Light

# Arama
/api/products/?search=ethiopia

# Sıralama
/api/products/?ordering=-price     # Fiyata göre azalan
/api/products/?ordering=rating     # Puana göre artan

# Kombinasyon
/api/products/?category=beans&roast=Light&ordering=-rating
```

## 📁 Proje Yapısı

```
coffe/
├── backend/                    # Django Backend
│   ├── coffee_backend/         # Proje ayarları
│   │   ├── settings.py        # Django ayarları
│   │   └── urls.py            # URL routing
│   ├── products/              # Ürün uygulaması
│   │   ├── models.py          # Database modelleri
│   │   ├── admin.py           # Admin özelleştirmesi
│   │   ├── serializers.py     # DRF serializers
│   │   ├── views.py           # API views
│   │   └── urls.py            # API routing
│   ├── requirements.txt       # Python dependencies
│   └── Dockerfile             # Backend container
├── src/                       # React Frontend
│   ├── components/            # React bileşenleri
│   │   ├── Header.jsx         # Navigation bar
│   │   ├── Hero.jsx           # Hero section
│   │   ├── Products.jsx       # Ürün listesi
│   │   ├── About.jsx          # Hakkımızda
│   │   ├── Contact.jsx        # İletişim formu
│   │   └── Footer.jsx         # Footer
│   ├── services/              # API servisleri
│   │   └── api.js             # API helper functions
│   └── App.jsx                # Ana component
├── nginx.conf                 # Nginx konfigürasyonu
├── docker-compose.yml         # Docker Compose
├── Dockerfile.frontend        # Frontend container
├── Makefile                   # Komut kısayolları
├── generate-ssl.sh            # SSL oluşturma scripti
└── README.md                  # Bu dosya
```

## 🌐 Portlar

- **80**: HTTP (HTTPS'e yönlendirir)
- **443**: HTTPS (Frontend)
- **5432**: PostgreSQL
- **8000**: Django Backend (direkt erişim)

## 🗄️ Database

### Modeller

#### Category

- id (primary key, char)
- name (string)
- icon (emoji/char)
- description (text)
- order (integer)

#### Product

- id (auto)
- name (string)
- category (foreign key)
- price (decimal)
- image (image field - upload)
- origin (string)
- roast (choice: Light/Medium/Medium-Dark/Dark)
- description (text)
- rating (decimal, 0-5)
- in_stock (boolean)
- featured (boolean)
- created_at (datetime)
- updated_at (datetime)

#### TasteNote

- id (auto)
- product (foreign key)
- note (string)
- order (integer)

## 🔐 Güvenlik

### Development (Mevcut)

- ✅ Self-signed SSL sertifikası
- ✅ DEBUG=True (backend)
- ✅ CORS localhost'lara açık
- ✅ Basit şifreler

### Production İçin Öneriler

- ⚠️ Let's Encrypt sertifikası kullanın
- ⚠️ DEBUG=False yapın
- ⚠️ SECRET_KEY'i değiştirin (güçlü + random)
- ⚠️ ALLOWED_HOSTS'u sınırlayın
- ⚠️ CORS'u production domain'e ayarlayın
- ⚠️ Güçlü database şifreleri
- ⚠️ Environment variables kullanın
- ⚠️ Nginx rate limiting ekleyin
- ⚠️ Automated backups
- ⚠️ Monitoring ve logging

## 🐛 Sorun Giderme

### Frontend Açılmıyor

```bash
# Container durumunu kontrol et
make ps

# Frontend loglarını incele
make logs-frontend

# Nginx config test et
docker compose exec frontend nginx -t

# Yeniden başlat
make restart

# Rebuild et
make build-frontend
make up
```

### Backend API Çalışmıyor

```bash
# Backend loglarını incele
make logs-backend

# Database bağlantısını test et
make backend-shell
python manage.py check

# Migration durumunu kontrol et
make backend-shell
python manage.py showmigrations

# Yeniden migrate et
make migrate
```

### Database Bağlantı Hatası

```bash
# Database container durumu
make ps

# Database logları
make logs-db

# Database'e bağlan
make db-shell

# Sıfırla
make reset
```

### SSL Sertifika Hatası

```bash
# SSL'i yeniden oluştur
make ssl

# Frontend'i rebuild et
make build-frontend
make up

# Tarayıcı cache'ini temizle
# Chrome: Ctrl+Shift+Del veya Cmd+Shift+Del
```

### Port Çakışması

```bash
# Çalışan tüm container'ları durdur
make stop-all

# Port kullanımını kontrol et
lsof -i :80
lsof -i :443
lsof -i :8000

# docker-compose.yml'de portları değiştir
# Örnek: 8080:80, 8443:443
```

### Disk Alanı Problemi

```bash
# Disk kullanımını kontrol et
make disk

# Temizlik yap
make clean-cache
make clean-images

# Tüm Docker temizliği (dikkatli!)
docker system prune -a --volumes
```

## 📊 Performans Optimizasyonu

### Frontend

- ✅ Vite build optimization
- ✅ Code splitting
- ✅ Gzip compression (Nginx)
- ✅ Static asset caching
- ✅ Image lazy loading

### Backend

- ✅ Database indexing
- ✅ Query optimization (select_related, prefetch_related)
- ✅ Pagination
- ✅ API response caching (eklenebilir)

### Docker

- ✅ Multi-stage builds
- ✅ Layer caching
- ✅ Minimal base images (alpine)
- ✅ .dockerignore optimization

## 🧪 Testing

```bash
# Backend testleri
make test

# Django shell ile manuel test
make shell

# API endpoint testleri
curl -sk https://localhost/api/products/ | jq
curl -sk https://localhost/api/categories/ | jq

# Sağlık kontrolü
make health
```

## 📦 Deployment

### Development (Mevcut)

```bash
make up
```

### Staging

```bash
# .env dosyası oluştur
cp .env.example .env
# .env'i düzenle

# Build ve başlat
docker compose -f docker-compose.staging.yml up -d --build
```

### Production

1. **SSL Sertifikası** (Let's Encrypt):

```bash
# Certbot ile sertifika al
certbot certonly --standalone -d yourdomain.com
```

2. **Environment Variables**:

```bash
# .env.production oluştur
DEBUG=False
SECRET_KEY=<strong-random-key>
ALLOWED_HOSTS=yourdomain.com
CORS_ALLOWED_ORIGINS=https://yourdomain.com
```

3. **Deploy**:

```bash
docker compose -f docker-compose.prod.yml up -d --build
```

## 🔄 Güncelleme

### Kod Değişiklikleri

```bash
# Git'ten çek
git pull origin main

# Sistemi güncelle
make update
```

### Database Migration

```bash
# Yeni model değişikliği
make makemigrations

# Migration uygula
make migrate

# Rollback (gerekirse)
docker compose exec backend python manage.py migrate products <migration_name>
```

## 💾 Backup & Restore

### Backup Alma

```bash
# Database backup
make db-backup
# Dosya: backup_YYYYMMDD_HHMMSS.sql

# Manuel backup
docker compose exec db pg_dump -U coffee_user coffee_db > my_backup.sql

# Media files backup
docker compose exec backend tar -czf /app/media_backup.tar.gz /app/media
docker cp coffee_backend:/app/media_backup.tar.gz ./
```

### Restore Etme

```bash
# Database restore
make db-restore file=backup_20231025_120000.sql

# Manuel restore
docker compose exec -T db psql -U coffee_user coffee_db < backup.sql

# Media files restore
docker cp media_backup.tar.gz coffee_backend:/app/
docker compose exec backend tar -xzf /app/media_backup.tar.gz -C /
```

## 📚 Ek Kaynaklar

- [Makefile Komutları](Makefile) - Tüm komutların detaylı açıklaması
- [Docker Setup Guide](DOCKER_SETUP.md) - Detaylı Docker kurulum ve kullanım
- [API Documentation](API_DOCS.md) - Detaylı API dokümantasyonu
- [Django Documentation](https://docs.djangoproject.com/)
- [React Documentation](https://react.dev/)
- [Docker Documentation](https://docs.docker.com/)
- [Nginx Documentation](https://nginx.org/en/docs/)

## 🤝 Katkıda Bulunma

1. Fork yapın
2. Feature branch oluşturun (`git checkout -b feature/amazing`)
3. Commit yapın (`git commit -m 'Add amazing feature'`)
4. Push edin (`git push origin feature/amazing`)
5. Pull Request açın

## 📝 Changelog

### v2.1.0 (2024-10-25)

- ✨ E-commerce özellikleri kaldırıldı (sepet, kullanıcı kaydı vb.)
- ✨ Otomatik admin kullanıcı oluşturma
- ✨ `make up` ile otomatik setup
- ✨ Bilgi alma butonları eklendi
- ✨ Platform bilgilendirme odaklı hale getirildi

### v2.0.0 (2024-10-25)

- ✨ Frontend Dockerize edildi
- ✨ Nginx + HTTPS desteği eklendi
- ✨ Makefile ile tek komut yönetimi
- ✨ Resim upload sistemi
- ✨ Admin panel toplu işlemler
- ✨ Otomatik SSL sertifika oluşturma

### v1.0.0 (2024-10-24)

- 🎉 İlk release
- Backend API (Django + DRF)
- Frontend (React + Vite)
- Docker Compose setup

## 📄 Lisans

MIT License

## 👨‍💻 Geliştirici

Coffee Paradise Team

## 🆘 Destek

Sorularınız için:

- Issue açın
- Pull request gönderin
- Email: yusufdgrl72@gmail.com (örnek)

---

**🎉 Keyifli kodlamalar! ☕**

```bash
# Başlamak için:
make fresh

# Yardım için:
make help

# Sorun mu var?
make check
make health
```
