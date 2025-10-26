.PHONY: help install ssl up down restart logs ps build rebuild clean shell backend-shell frontend-shell db-shell migrate makemigrations seed superuser test status dev prod stop-all

# Default target
.DEFAULT_GOAL := help

# Colors for output
BLUE := \033[0;34m
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

help: ## 📚 Tüm komutları göster
	@echo "$(BLUE)☕ Coffee Paradise - Makefile Komutları$(NC)"
	@echo ""
	@awk 'BEGIN {FS = ":.*##"; printf "\nKullanım:\n  make $(YELLOW)<target>$(NC)\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  $(BLUE)%-20s$(NC) %s\n", $$1, $$2 } /^##@/ { printf "\n$(GREEN)%s$(NC)\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
	@echo ""

##@ 🚀 Başlangıç Komutları

install: ## 📦 İlk kurulum (SSL + Dependencies)
	@echo "$(GREEN)📦 Kurulum başlatılıyor...$(NC)"
	@if [ ! -d "ssl" ] || [ ! -f "ssl/localhost.crt" ]; then \
		echo "$(YELLOW)🔐 SSL sertifikası oluşturuluyor...$(NC)"; \
		chmod +x generate-ssl.sh; \
		./generate-ssl.sh; \
	else \
		echo "$(GREEN)✅ SSL sertifikası zaten mevcut$(NC)"; \
	fi
	@echo "$(YELLOW)📥 npm bağımlılıkları yükleniyor...$(NC)"
	@npm install
	@echo "$(GREEN)✅ Kurulum tamamlandı!$(NC)"
	@echo "$(BLUE)Şimdi 'make up' komutuyla sistemi başlatabilirsiniz.$(NC)"

ssl: ## 🔐 SSL sertifikası oluştur/yenile
	@echo "$(YELLOW)🔐 SSL sertifikası oluşturuluyor...$(NC)"
	@rm -rf ssl/
	@chmod +x generate-ssl.sh
	@./generate-ssl.sh
	@echo "$(GREEN)✅ SSL sertifikası hazır!$(NC)"

##@ 🏃 Sistem Yönetimi

up: ## ⬆️  Tüm servisleri başlat (build + up)
	@echo "$(GREEN)🚀 Sistem başlatılıyor...$(NC)"
	@docker compose up -d --build
	@echo "$(BLUE)⏳ Servislerin hazır olması bekleniyor...$(NC)"
	@sleep 5
	@echo "$(YELLOW)🔄 Database migration çalıştırılıyor...$(NC)"
	@docker compose exec backend python manage.py migrate --noinput 2>/dev/null || true
	@echo "$(YELLOW)👤 Admin kullanıcısı kontrol ediliyor...$(NC)"
	@docker compose exec backend python manage.py shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.filter(username='admin').exists() or User.objects.create_superuser('admin', 'admin@coffee.com', 'admin123')" 2>/dev/null || true
	@make status
	@echo ""
	@echo "$(GREEN)✅ Sistem hazır!$(NC)"
	@echo ""
	@echo "$(BLUE)📍 Giriş Bilgileri:$(NC)"
	@echo "   Kullanıcı: $(GREEN)admin$(NC)"
	@echo "   Şifre:     $(GREEN)admin123$(NC)"
	@echo ""
	@echo "$(BLUE)📍 URL'ler:$(NC)"
	@echo "   Frontend: $(GREEN)https://localhost$(NC)"
	@echo "   Admin:    $(GREEN)https://localhost/admin$(NC)"
	@echo "   API:      $(GREEN)https://localhost/api/$(NC)"

down: ## ⬇️  Tüm servisleri durdur
	@echo "$(YELLOW)🛑 Servisler durduruluyor...$(NC)"
	@docker compose down
	@echo "$(GREEN)✅ Servisler durduruldu$(NC)"

restart: ## 🔄 Tüm servisleri yeniden başlat
	@echo "$(YELLOW)🔄 Servisler yeniden başlatılıyor...$(NC)"
	@docker compose restart
	@echo "$(GREEN)✅ Servisler yeniden başlatıldı$(NC)"
	@make status

stop: ## ⏸️  Tüm servisleri duraklat
	@echo "$(YELLOW)⏸️  Servisler duraklatılıyor...$(NC)"
	@docker compose stop
	@echo "$(GREEN)✅ Servisler duraklatıldı$(NC)"

start: ## ▶️  Duraklatılmış servisleri başlat
	@echo "$(GREEN)▶️  Servisler başlatılıyor...$(NC)"
	@docker compose start
	@echo "$(GREEN)✅ Servisler başlatıldı$(NC)"

##@ 🔍 Monitoring & Logs

logs: ## 📋 Tüm servislerin loglarını göster
	@docker compose logs -f

logs-frontend: ## 📋 Frontend logları
	@docker compose logs -f frontend

logs-backend: ## 📋 Backend logları
	@docker compose logs -f backend

logs-db: ## 📋 Database logları
	@docker compose logs -f db

ps: ## 📊 Çalışan servisleri listele
	@docker compose ps

status: ## 🔍 Sistem durumunu göster
	@echo "$(BLUE)📊 Sistem Durumu:$(NC)"
	@docker compose ps
	@echo ""
	@echo "$(BLUE)💾 Disk Kullanımı:$(NC)"
	@docker system df

##@ 🛠️  Build & Development

build: ## 🏗️  Tüm servisleri build et
	@echo "$(YELLOW)🏗️  Servisler build ediliyor...$(NC)"
	@docker compose build
	@echo "$(GREEN)✅ Build tamamlandı$(NC)"

rebuild: ## 🔨 Cache kullanmadan rebuild (temiz build)
	@echo "$(YELLOW)🔨 Temiz build başlatılıyor...$(NC)"
	@docker compose build --no-cache
	@echo "$(GREEN)✅ Rebuild tamamlandı$(NC)"

build-frontend: ## 🎨 Sadece frontend build et
	@echo "$(YELLOW)🎨 Frontend build ediliyor...$(NC)"
	@docker compose build frontend --no-cache
	@echo "$(GREEN)✅ Frontend build tamamlandı$(NC)"

build-backend: ## 🔧 Sadece backend build et
	@echo "$(YELLOW)🔧 Backend build ediliyor...$(NC)"
	@docker compose build backend --no-cache
	@echo "$(GREEN)✅ Backend build tamamlandı$(NC)"

dev: ## 💻 Development modunda başlat (hot-reload)
	@echo "$(GREEN)💻 Development modu başlatılıyor...$(NC)"
	@docker compose up
	
prod: ## 🚀 Production modunda başlat
	@echo "$(GREEN)🚀 Production modu başlatılıyor...$(NC)"
	@docker compose up -d --build
	@make status

##@ 🗄️  Database Komutları

migrate: ## 🔄 Database migration çalıştır
	@echo "$(YELLOW)🔄 Migration çalıştırılıyor...$(NC)"
	@docker compose exec backend python manage.py migrate
	@echo "$(GREEN)✅ Migration tamamlandı$(NC)"

makemigrations: ## 📝 Yeni migration oluştur
	@echo "$(YELLOW)📝 Migration dosyası oluşturuluyor...$(NC)"
	@docker compose exec backend python manage.py makemigrations
	@echo "$(GREEN)✅ Migration dosyası oluşturuldu$(NC)"

seed: ## 🌱 Örnek veri yükle
	@echo "$(YELLOW)🌱 Örnek veriler yükleniyor...$(NC)"
	@docker compose exec backend python manage.py seed_data
	@echo "$(GREEN)✅ Örnek veriler yüklendi$(NC)"

superuser: ## 👤 Admin kullanıcı oluştur
	@echo "$(YELLOW)👤 Admin kullanıcısı oluşturuluyor...$(NC)"
	@docker compose exec backend python manage.py createsuperuser

db-backup: ## 💾 Database backup al
	@echo "$(YELLOW)💾 Database backup alınıyor...$(NC)"
	@docker compose exec db pg_dump -U coffee_user coffee_db > backup_$$(date +%Y%m%d_%H%M%S).sql
	@echo "$(GREEN)✅ Backup alındı: backup_$$(date +%Y%m%d_%H%M%S).sql$(NC)"

db-restore: ## 📥 Database restore et (file=backup.sql)
	@if [ -z "$(file)" ]; then \
		echo "$(RED)❌ Hata: Backup dosyası belirtilmedi$(NC)"; \
		echo "$(YELLOW)Kullanım: make db-restore file=backup.sql$(NC)"; \
		exit 1; \
	fi
	@echo "$(YELLOW)📥 Database restore ediliyor: $(file)$(NC)"
	@docker compose exec -T db psql -U coffee_user coffee_db < $(file)
	@echo "$(GREEN)✅ Restore tamamlandı$(NC)"

##@ 🐚 Shell Komutları

shell: ## 🐚 Backend shell (Django shell)
	@docker compose exec backend python manage.py shell

backend-shell: ## 🔧 Backend container bash
	@docker compose exec backend bash

frontend-shell: ## 🎨 Frontend container shell
	@docker compose exec frontend sh

db-shell: ## 🗄️  PostgreSQL shell
	@docker compose exec db psql -U coffee_user -d coffee_db

##@ 🧹 Temizlik Komutları

clean: ## 🧹 Tüm container ve volume'leri temizle
	@echo "$(RED)⚠️  Bu işlem TÜM VERİLERİ silecek!$(NC)"
	@echo "$(YELLOW)Devam etmek için 'yes' yazın:$(NC)"
	@read -p "" confirm; \
	if [ "$$confirm" = "yes" ]; then \
		echo "$(RED)🧹 Temizlik başlatılıyor...$(NC)"; \
		docker compose down -v; \
		docker system prune -af; \
		rm -rf node_modules dist; \
		echo "$(GREEN)✅ Temizlik tamamlandı$(NC)"; \
	else \
		echo "$(BLUE)İptal edildi$(NC)"; \
	fi

clean-volumes: ## 🗑️  Sadece volume'leri temizle (veri kaybolur!)
	@echo "$(RED)⚠️  Bu işlem TÜM DATABASE VERİLERİNİ silecek!$(NC)"
	@echo "$(YELLOW)Devam etmek için 'yes' yazın:$(NC)"
	@read -p "" confirm; \
	if [ "$$confirm" = "yes" ]; then \
		echo "$(RED)🗑️  Volume'ler siliniyor...$(NC)"; \
		docker compose down -v; \
		echo "$(GREEN)✅ Volume'ler silindi$(NC)"; \
	else \
		echo "$(BLUE)İptal edildi$(NC)"; \
	fi

clean-images: ## 🗑️  Docker image'leri temizle
	@echo "$(YELLOW)🗑️  Kullanılmayan image'ler temizleniyor...$(NC)"
	@docker image prune -af
	@echo "$(GREEN)✅ Image'ler temizlendi$(NC)"

clean-cache: ## 🧹 Build cache temizle
	@echo "$(YELLOW)🧹 Build cache temizleniyor...$(NC)"
	@rm -rf node_modules/.vite
	@docker builder prune -af
	@echo "$(GREEN)✅ Cache temizlendi$(NC)"

##@ 🧪 Test & Debug

test: ## 🧪 Testleri çalıştır
	@echo "$(YELLOW)🧪 Testler çalıştırılıyor...$(NC)"
	@docker compose exec backend python manage.py test
	@echo "$(GREEN)✅ Testler tamamlandı$(NC)"

check: ## ✅ Sistem kontrolü yap
	@echo "$(BLUE)✅ Sistem kontrol ediliyor...$(NC)"
	@echo ""
	@echo "$(YELLOW)📦 Docker:$(NC)"
	@docker --version
	@docker compose version
	@echo ""
	@echo "$(YELLOW)🔐 SSL:$(NC)"
	@if [ -f "ssl/localhost.crt" ]; then \
		echo "$(GREEN)✅ SSL sertifikası mevcut$(NC)"; \
	else \
		echo "$(RED)❌ SSL sertifikası bulunamadı$(NC)"; \
		echo "$(YELLOW)   'make ssl' komutuyla oluşturun$(NC)"; \
	fi
	@echo ""
	@echo "$(YELLOW)🐳 Container'lar:$(NC)"
	@docker compose ps
	@echo ""
	@echo "$(YELLOW)🌐 URL'ler:$(NC)"
	@echo "$(BLUE)   Frontend: https://localhost$(NC)"
	@echo "$(BLUE)   Admin:    https://localhost/admin$(NC)"
	@echo "$(BLUE)   API:      https://localhost/api/products/$(NC)"
	@echo "$(BLUE)   Backend:  http://localhost:8000$(NC)"

health: ## 💊 Servislerin sağlık kontrolü
	@echo "$(BLUE)💊 Sağlık kontrolü yapılıyor...$(NC)"
	@echo ""
	@echo "$(YELLOW)Frontend:$(NC)"
	@curl -sk https://localhost > /dev/null 2>&1 && echo "$(GREEN)✅ Çalışıyor$(NC)" || echo "$(RED)❌ Çalışmıyor$(NC)"
	@echo ""
	@echo "$(YELLOW)Backend API:$(NC)"
	@curl -sk https://localhost/api/products/ > /dev/null 2>&1 && echo "$(GREEN)✅ Çalışıyor$(NC)" || echo "$(RED)❌ Çalışmıyor$(NC)"
	@echo ""
	@echo "$(YELLOW)Admin Panel:$(NC)"
	@curl -sk https://localhost/admin/ > /dev/null 2>&1 && echo "$(GREEN)✅ Çalışıyor$(NC)" || echo "$(RED)❌ Çalışmıyor$(NC)"

##@ 📦 Hızlı İşlemler

reset: down clean-volumes up migrate seed superuser ## 🔄 Sistemi sıfırla ve yeniden kur
	@echo "$(GREEN)✅ Sistem sıfırlandı ve yeniden kuruldu$(NC)"

update: down build up ## 🔄 Sistemi güncelle (rebuild + restart)
	@echo "$(GREEN)✅ Sistem güncellendi$(NC)"

quick: ## ⚡ Hızlı başlat (build olmadan)
	@echo "$(GREEN)⚡ Hızlı başlatma...$(NC)"
	@docker compose up -d
	@make status

stop-all: ## 🛑 Tüm Docker container'larını durdur
	@echo "$(RED)🛑 TÜM Docker container'ları durduruluyor...$(NC)"
	@docker stop $$(docker ps -aq) 2>/dev/null || true
	@echo "$(GREEN)✅ Tüm container'lar durduruldu$(NC)"

##@ 📊 İstatistikler

stats: ## 📊 Container kaynak kullanımı
	@docker stats --no-stream

disk: ## 💾 Docker disk kullanımı
	@docker system df -v

info: ## ℹ️  Sistem bilgisi
	@echo "$(BLUE)ℹ️  Sistem Bilgisi$(NC)"
	@echo ""
	@echo "$(YELLOW)Docker:$(NC)"
	@docker info | grep -E "Server Version|Operating System|Total Memory|CPUs"
	@echo ""
	@echo "$(YELLOW)Disk Kullanımı:$(NC)"
	@docker system df
	@echo ""
	@echo "$(YELLOW)Volume'ler:$(NC)"
	@docker volume ls | grep coffe

##@ 🎯 Özel Senaryolar

fresh: install up migrate seed ## 🆕 Sıfırdan kurulum (ilk kez)
	@echo ""
	@echo "$(GREEN)🎉 Kurulum tamamlandı! Admin kullanıcısı otomatik oluşturuldu.$(NC)"
	@echo ""
	@echo "$(BLUE)📍 Giriş Bilgileri:$(NC)"
	@echo "   Kullanıcı: $(GREEN)admin$(NC)"
	@echo "   Şifre:     $(GREEN)admin123$(NC)"
	@echo ""
	@echo "$(BLUE)📍 URL'ler:$(NC)"
	@echo "   Frontend: $(GREEN)https://localhost$(NC)"
	@echo "   Admin:    $(GREEN)https://localhost/admin$(NC)"
	@echo "   API:      $(GREEN)https://localhost/api/$(NC)"
	@echo ""
	@echo "$(YELLOW)⚠️  Not: Tarayıcı SSL uyarısı verecek - 'Advanced' > 'Proceed' yapın$(NC)"

demo: down clean-volumes up migrate seed ## 🎭 Demo verilerle başlat
	@echo ""
	@echo "$(GREEN)🎭 Demo sistemi hazır! Admin kullanıcısı otomatik oluşturuldu.$(NC)"
	@echo ""
	@echo "$(BLUE)📍 Giriş Bilgileri:$(NC)"
	@echo "   Kullanıcı: $(GREEN)admin$(NC)"
	@echo "   Şifre:     $(GREEN)admin123$(NC)"
	@echo ""
	@make check

