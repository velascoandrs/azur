from django_filters.rest_framework import FilterSet, NumberFilter, CharFilter

from apps.inmuebles.models import Inmueble


class InmuebleFilter(FilterSet):
    titulo = CharFilter(method='filtro_titulo', field_name='titulo')
    tipo = NumberFilter(method='filtro_tipo', field_name='tipo')

    class Meta:
        model = Inmueble
        fields = {
            'titulo',
            'tipo'
        }

    def filtro_titulo(self, queryset, name, value):
        return queryset.filter(titulo__contains=value)

    def filtro_tipo(self,queryset,name,value):
        return queryset.filter(tipo__id = value)
