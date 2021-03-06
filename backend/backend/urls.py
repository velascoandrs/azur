"""backend URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.conf.urls import url
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import path, include
from rest_framework_simplejwt import views as jwt_views
from django.conf import settings

from apps.ciudad.models import Ciudad
from apps.usuarios.api_auth import ObtenerUsuario
from backend.funciones import crear_datos

urlpatterns = [
    path('admin/', admin.site.urls),
    url(r'^api-auth/', include('rest_framework.urls')),
    # Para la autentifiacion de la API.
    path('api/token/', jwt_views.TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', jwt_views.TokenRefreshView.as_view(), name='token_refresh'),
    path('api/usuario/get', ObtenerUsuario.as_view(), name='usuario'),
    path('usuarios/', include(('apps.usuarios.urls', 'usuarios'), namespace="usuarios")),
    path('inmuebles/', include(('apps.inmuebles.urls', 'inmuebles'), namespace="inmuebles")),
    path('ciudad/', include(('apps.ciudad.urls', 'ciudad'), namespace="ciudad"))

] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

crear_datos(ruta='datos-prueba/datos-ciudad.json', model=Ciudad, nombreEntidad='ciudad')
