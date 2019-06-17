from django.conf.urls import url
from django.urls import path

from apps.usuarios.api_auth import create_user, existe_correo
from apps.usuarios.views import activate

urlpatterns = [
    path('crear_usuario', create_user),
    path('activar/<str:codigo>', activate, name='activar'),
    path('api/v1/ex_correo/<str:correo>', existe_correo)
]