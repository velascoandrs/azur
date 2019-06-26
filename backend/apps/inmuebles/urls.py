from django.urls import path

from apps.inmuebles.api import ListaInmuebles, publicar_inmueble, Upload, existe_predio

urlpatterns = [
    path('api/v1/inmuebles/', ListaInmuebles.as_view()),
    path('api/v1/inmuebles/post', Upload.as_view()),
    path('api/v1/ex_predio/<int:predio>', existe_predio),
]