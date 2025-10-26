# 📡 API Dokümantasyonu

## Base URL

```
http://localhost:8000/api
```

## Endpoints

### 📂 Kategoriler

#### Tüm Kategorileri Listele

```http
GET /api/categories/
```

**Response:**

```json
[
  {
    "id": "beans",
    "name": "Kahve Çekirdekleri",
    "icon": "🫘",
    "description": "Taze kavrum çekirdekler"
  },
  {
    "id": "ground",
    "name": "Öğütülmüş Kahve",
    "icon": "🌰",
    "description": "Hazır öğütülmüş"
  }
]
```

#### Tek Kategori

```http
GET /api/categories/{id}/
```

**Example:**

```bash
curl http://localhost:8000/api/categories/beans/
```

---

### ☕ Ürünler

#### Tüm Ürünleri Listele

```http
GET /api/products/
```

**Response:**

```json
[
  {
    "id": 1,
    "name": "Ethiopia Yirgacheffe",
    "category": "beans",
    "price": "285.00",
    "image": "https://images.unsplash.com/...",
    "origin": "Etiyopya",
    "roast": "Light",
    "description": "Etiyopyanın en prestijli bölgesinden...",
    "rating": "4.9",
    "in_stock": true,
    "notes": ["Çiçeksi", "Narenciye", "Bergamot"]
  }
]
```

#### Tek Ürün Detayı

```http
GET /api/products/{id}/
```

**Response:**

```json
{
  "id": 1,
  "name": "Ethiopia Yirgacheffe",
  "category": "beans",
  "category_name": "Kahve Çekirdekleri",
  "price": "285.00",
  "image": "https://images.unsplash.com/...",
  "origin": "Etiyopya",
  "roast": "Light",
  "description": "Detaylı açıklama...",
  "rating": "4.9",
  "in_stock": true,
  "featured": true,
  "notes": [
    { "note": "Çiçeksi" },
    { "note": "Narenciye" },
    { "note": "Bergamot" }
  ],
  "created_at": "2024-01-15T10:30:00Z",
  "updated_at": "2024-01-15T10:30:00Z"
}
```

#### Kategoriye Göre Ürünler

```http
GET /api/products/by_category/?category={category_id}
```

**Examples:**

```bash
# Tüm ürünler
curl http://localhost:8000/api/products/by_category/?category=all

# Sadece çekirdekler
curl http://localhost:8000/api/products/by_category/?category=beans
```

#### Öne Çıkan Ürünler

```http
GET /api/products/featured/
```

#### Stokta Olan Ürünler

```http
GET /api/products/in_stock/
```

---

## 🔍 Filtreleme ve Arama

### Query Parameters

#### Kategoriye Göre Filtre

```bash
GET /api/products/?category=beans
```

#### Stok Durumuna Göre

```bash
GET /api/products/?in_stock=true
```

#### Öne Çıkan Ürünler

```bash
GET /api/products/?featured=true
```

#### Kavurma Seviyesine Göre

```bash
GET /api/products/?roast=Light
```

Seçenekler: `Light`, `Medium`, `Medium-Dark`, `Dark`

#### Arama

```bash
GET /api/products/?search=ethiopia
```

Arama alanları: `name`, `description`, `origin`

#### Sıralama

```bash
# Fiyata göre artan
GET /api/products/?ordering=price

# Fiyata göre azalan
GET /api/products/?ordering=-price

# Puana göre
GET /api/products/?ordering=-rating

# Tarihe göre (en yeni)
GET /api/products/?ordering=-created_at
```

#### Kombinasyon

```bash
GET /api/products/?category=beans&roast=Light&ordering=-rating&search=ethiopia
```

---

## ✏️ CRUD Operasyonları

### Yeni Ürün Oluştur

```http
POST /api/products/
Content-Type: application/json
```

**Request Body:**

```json
{
  "name": "Kenya AA",
  "category": "beans",
  "price": 295,
  "image": "https://images.unsplash.com/photo-xxx",
  "origin": "Kenya",
  "roast": "Medium",
  "description": "Kenya'nın yüksek rakımlı bölgelerinden...",
  "rating": 4.8,
  "in_stock": true,
  "featured": false,
  "notes": ["Çiçeksi", "Yaban Mersini", "Limon"]
}
```

**cURL Example:**

```bash
curl -X POST http://localhost:8000/api/products/ \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Kenya AA",
    "category": "beans",
    "price": 295,
    "image": "https://images.unsplash.com/photo-587734195503-904fca47e0e9?w=800",
    "origin": "Kenya",
    "roast": "Medium",
    "description": "Kenya description",
    "rating": 4.8,
    "in_stock": true,
    "featured": false,
    "notes": ["Çiçeksi", "Yaban Mersini"]
  }'
```

### Ürün Güncelle

```http
PUT /api/products/{id}/
Content-Type: application/json
```

**Request Body:** (Tüm alanlar)

```json
{
  "name": "Kenya AA Updated",
  "category": "beans",
  "price": 299,
  ...
}
```

### Ürün Kısmi Güncelleme

```http
PATCH /api/products/{id}/
Content-Type: application/json
```

**Request Body:** (Sadece değişen alanlar)

```json
{
  "price": 299,
  "in_stock": false
}
```

### Ürün Sil

```http
DELETE /api/products/{id}/
```

---

## 📊 Pagination

API otomatik olarak sayfalama yapar (100 öğe/sayfa).

**Response:**

```json
{
  "count": 250,
  "next": "http://localhost:8000/api/products/?page=2",
  "previous": null,
  "results": [...]
}
```

**Sayfa Parametresi:**

```bash
GET /api/products/?page=2
```

---

## ❌ Hata Kodları

| Status Code | Açıklama       |
| ----------- | -------------- |
| 200         | Başarılı       |
| 201         | Oluşturuldu    |
| 204         | Silindi        |
| 400         | Geçersiz istek |
| 404         | Bulunamadı     |
| 500         | Sunucu hatası  |

**Hata Response:**

```json
{
  "detail": "Not found."
}
```

---

## 🔐 Authentication

Şu an için authentication gerekmiyor. Production için eklenebilir:

```python
# settings.py
REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': [
        'rest_framework.authentication.SessionAuthentication',
        'rest_framework.authentication.TokenAuthentication',
    ]
}
```

---

## 🧪 Test Örnekleri

### JavaScript/Fetch

```javascript
// Ürünleri çek
fetch("http://localhost:8000/api/products/")
  .then((res) => res.json())
  .then((data) => console.log(data));

// Yeni ürün ekle
fetch("http://localhost:8000/api/products/", {
  method: "POST",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({
    name: "Test Product",
    category: "beans",
    price: 250,
    // ...
  }),
});
```

### Python/Requests

```python
import requests

# GET
response = requests.get('http://localhost:8000/api/products/')
products = response.json()

# POST
data = {
    'name': 'Test Product',
    'category': 'beans',
    'price': 250,
}
response = requests.post(
    'http://localhost:8000/api/products/',
    json=data
)
```

### cURL

```bash
# GET ile test
curl http://localhost:8000/api/products/ | jq

# POST ile test
curl -X POST http://localhost:8000/api/products/ \
  -H "Content-Type: application/json" \
  -d '{"name":"Test","category":"beans","price":250,...}'

# PUT ile test
curl -X PUT http://localhost:8000/api/products/1/ \
  -H "Content-Type: application/json" \
  -d '{"name":"Updated","category":"beans",...}'

# DELETE ile test
curl -X DELETE http://localhost:8000/api/products/1/
```

---

## 🎯 Frontend Entegrasyonu

Projede `src/services/api.js` dosyası kullanılıyor:

```javascript
import { getProducts, getProductsByCategory } from "../services/api";

// Component içinde
const [products, setProducts] = useState([]);

useEffect(() => {
  async function fetchData() {
    const data = await getProducts();
    setProducts(data);
  }
  fetchData();
}, []);
```

---

## 🌐 CORS

CORS ayarları `backend/coffee_backend/settings.py`:

```python
CORS_ALLOWED_ORIGINS = [
    'http://localhost:5173',
    'http://localhost:5174',
    'http://localhost:5175',
]
```

Production için domain ekleyin.
