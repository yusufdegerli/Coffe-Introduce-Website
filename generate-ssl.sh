#!/bin/bash

# SSL sertifikası oluşturma scripti
echo "🔐 Localhost için SSL sertifikası oluşturuluyor..."

# SSL klasörünü oluştur
mkdir -p ssl

# Self-signed sertifika oluştur
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout ssl/localhost.key \
    -out ssl/localhost.crt \
    -subj "/C=TR/ST=Istanbul/L=Istanbul/O=Coffee Paradise/OU=Development/CN=localhost" \
    -addext "subjectAltName=DNS:localhost,DNS:*.localhost,IP:127.0.0.1"

# Dosya izinlerini ayarla
chmod 644 ssl/localhost.crt
chmod 600 ssl/localhost.key

echo "✅ SSL sertifikası oluşturuldu!"
echo "📁 Dosyalar: ssl/localhost.crt ve ssl/localhost.key"
echo ""
echo "⚠️  Not: Bu self-signed sertifika development içindir."
echo "   Tarayıcı güvenlik uyarısı verecektir - 'Advanced' -> 'Proceed' yapın."

