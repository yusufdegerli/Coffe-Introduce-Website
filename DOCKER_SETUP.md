# 🐳 Docker + HTTPS Setup Guide

## 🚀 Hızlı Başlangıç

### 1. SSL Sertifikası Oluştur

```bash
# SSL sertifikası oluştur (sadece ilk seferinde)
chmod +x generate-ssl.sh
./generate-ssl.sh
```

### 2. Docker ile Çalıştır

```bash
# Tüm servisleri başlat
docker compose up -d --build

# Logları izle
docker compose logs -f

# Durum kontrol et
docker compose ps
```

### 3. Erişim

- **Frontend (HTTPS)**: https://localhost
- **Frontend (HTTP)**: http://localhost (otomatik HTTPS'e yönlendirir)
- **Admin Paneli**: https://localhost/admin
- **API**: https://localhost/api/products/
- **Backend (direkt)**: http://localhost:8000

## 🔐 HTTPS Sertifika Uyarısı

İlk açılışta tarayıcı güvenlik uyarısı verecek (self-signed sertifika):

### Chrome/Edge:

1. "Advanced" veya "Gelişmiş" tıklayın
2. "Proceed to localhost (unsafe)" veya "localhost sitesine devam et" tıklayın

### Firefox:

1. "Advanced" veya "Gelişmiş" tıklayın
2. "Accept the Risk and Continue" veya "Riski kabul et ve devam et" tıklayın

### Safari:

1. "Show Details" tıklayın
2. "Visit this website" tıklayın
3. Şifrenizi girin ve onaylayın

## 📦 Servisler

### Frontend (Nginx + React)

- **Port 80**: HTTP (HTTPS'e yönlendirir)
- **Port 443**: HTTPS
- **Container**: coffee_frontend
- **Teknoloji**: React + Vite + Nginx

### Backend (Django)

- **Port 8000**: Django API
- **Container**: coffee_backend
- **Teknoloji**: Django + DRF + PostgreSQL

### Database (PostgreSQL)

- **Port 5432**: PostgreSQL
- **Container**: coffee_db

## 🛠️ Komutlar

### Tüm Servisleri Yönet

```bash
# Başlat
docker compose up -d

# Durdur
docker compose down

# Yeniden başlat
docker compose restart

# Logları görüntüle
docker compose logs -f

# Belirli bir servisin logları
docker compose logs -f frontend
docker compose logs -f backend

# Container'lara bağlan
docker compose exec frontend sh
docker compose exec backend bash
```

### Frontend

```bash
# Frontend'i yeniden build et
docker compose build frontend --no-cache

# Frontend'i yeniden başlat
docker compose restart frontend

# Frontend container'a bağlan
docker compose exec frontend sh
```

### Backend

```bash
# Migration çalıştır
docker compose exec backend python manage.py migrate

# Admin kullanıcı oluştur
docker compose exec backend python manage.py createsuperuser

# Örnek veri yükle
docker compose exec backend python manage.py seed_data

# Django shell
docker compose exec backend python manage.py shell
```

### Database

```bash
# PostgreSQL'e bağlan
docker compose exec db psql -U coffee_user -d coffee_db

# Database backup
docker compose exec db pg_dump -U coffee_user coffee_db > backup.sql

# Database restore
docker compose exec -T db psql -U coffee_user coffee_db < backup.sql
```

## 🔄 Güncelleme Sonrası

Frontend veya backend kodu değiştiğinde:

```bash
# Frontend değişti
docker compose build frontend --no-cache
docker compose up -d frontend

# Backend değişti (kod hot-reload ile otomatik güncellenir)
docker compose restart backend

# Her ikisi de değişti
docker compose down
docker compose up -d --build
```

## 🗂️ Volumes

```bash
# Tüm volume'leri listele
docker volume ls | grep coffe

# Volume içeriğini görüntüle
docker compose exec backend ls -la /app/media

# Volume'leri temizle (VERİ SİLİNİR!)
docker compose down -v
```

## 🐛 Sorun Giderme

### Frontend Açılmıyor

```bash
# Container çalışıyor mu?
docker compose ps frontend

# Logları kontrol et
docker compose logs -f frontend

# Nginx config test et
docker compose exec frontend nginx -t

# Yeniden başlat
docker compose restart frontend
```

### Backend API Çalışmıyor

```bash
# Backend logları
docker compose logs -f backend

# Database bağlantısını test et
docker compose exec backend python manage.py check

# Migration durumu
docker compose exec backend python manage.py showmigrations
```

### HTTPS Çalışmıyor

```bash
# SSL sertifikalarını kontrol et
ls -la ssl/

# Yeniden oluştur
rm -rf ssl/
./generate-ssl.sh

# Frontend'i rebuild et
docker compose build frontend --no-cache
docker compose up -d frontend
```

### Port Çakışması

```bash
# Portları değiştir (docker-compose.yml)
# 443:443 yerine 8443:443
# https://localhost:8443 olur
```

## 🔒 Güvenlik Notları

### Development

- Self-signed sertifika kullanılıyor
- DEBUG=True (backend)
- CORS tüm localhost'lara açık

### Production İçin

- Let's Encrypt sertifikası kullanın
- DEBUG=False yapın
- SECRET_KEY'i değiştirin
- ALLOWED_HOSTS'u sınırlayın
- CORS'u production domain'e ayarlayın
- Güçlü şifreler kullanın

## 📊 Performans

### Build Optimizasyonu

```bash
# Sadece değişen servisleri build et
docker compose build <service-name>

# Cache kullanarak hızlı build
docker compose build

# Cache'siz build (temiz başlangıç)
docker compose build --no-cache
```

### Disk Alanı Temizliği

```bash
# Kullanılmayan image'leri temizle
docker image prune -a

# Kullanılmayan volume'leri temizle
docker volume prune

# Her şeyi temizle (dikkatli!)
docker system prune -a --volumes
```

## 🎯 Production Deployment

Production için öneriler:

1. **SSL Sertifikası**: Let's Encrypt kullanın
2. **Environment Variables**: .env dosyası kullanın
3. **Secrets Management**: Docker secrets kullanın
4. **Load Balancing**: Multiple frontend instances
5. **Monitoring**: Prometheus + Grafana
6. **Logging**: ELK Stack veya Loki
7. **Backup**: Automated database backups
8. **CI/CD**: GitHub Actions veya GitLab CI

## 📚 Daha Fazla Bilgi

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Nginx Documentation](https://nginx.org/en/docs/)
- [Django Deployment](https://docs.djangoproject.com/en/stable/howto/deployment/)

---

**Not**: Bu kurulum development ortamı içindir. Production deployment için ek güvenlik ve optimizasyon yapılmalıdır.
