import django_filters
from rest_framework import viewsets, filters

from apps.ciudad.models import Ciudad
from apps.ciudad.serializer import CiudadSerializer


class CiudadController(viewsets.ModelViewSet):
    queryset = Ciudad.objects.all()
    serializer_class = CiudadSerializer
    filter_backends = [django_filters.rest_framework.DjangoFilterBackend, filters.SearchFilter]
    search_fields = ['name']