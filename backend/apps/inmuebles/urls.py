from django.conf.urls import url
from django.urls import path, include
from rest_framework.routers import DefaultRouter

from apps.inmuebles.api import ListaInmuebles, publicar_inmueble, RegistrarInmueble, existe_predio, InmuebleAPI

router = DefaultRouter()
router.register(r'api/v2/inmuebles', InmuebleAPI)

urlpatterns = [
    url(r'^', include(router.urls)),
    path('api/v1/inmuebles/', ListaInmuebles.as_view()),
    path('api/v1/inmuebles/post', RegistrarInmueble.as_view()),
    path('api/v1/ex_predio/<int:predio>', existe_predio),
]