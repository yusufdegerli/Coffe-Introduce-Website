"""
URL configuration for coffee_backend project.
"""
from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('products.urls')),
]

# Serve media files in development (ALWAYS - çünkü media files her zaman serve edilmeli)
urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

# Serve static files only in development
if settings.DEBUG:
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)

# Admin site customization
admin.site.site_header = "Coffee Paradise Admin"
admin.site.site_title = "Coffee Paradise"
admin.site.index_title = "Kahve Ürün Yönetimi"

