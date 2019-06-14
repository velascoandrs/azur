from django.conf.urls import url
from django.urls import path

from apps.usuarios.api_auth import create_user
from apps.usuarios.views import activate

urlpatterns = [
    path('crear_usuario', create_user),
    url(r'^activar/(?P<uidb64>[0-9A-Za-z_\-]+)$', activate, name='activar'),
]