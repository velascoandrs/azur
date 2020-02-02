from django.conf.urls import url
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from apps.ciudad.api import CiudadController

router = DefaultRouter()
router.register(r'api/v2/cities', CiudadController)

urlpatterns = [
    url(r'^', include(router.urls)),
]