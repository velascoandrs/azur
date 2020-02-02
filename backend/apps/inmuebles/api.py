from _pydecimal import Decimal

import django_filters
from django.http import JsonResponse, HttpResponse
from django.shortcuts import get_object_or_404
from rest_framework import filters
from rest_framework import authentication, permissions, generics, status, viewsets
from rest_framework.decorators import api_view, permission_classes
from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from rest_framework.viewsets import ModelViewSet

from apps.inmuebles.filtros import InmuebleFilter
from apps.inmuebles.models import Inmueble, Imagen, TipoInmueble, Sector
from apps.inmuebles.serializers import InmuebleSerializador


class ListaInmuebles(generics.ListAPIView):
    """
    View to list all users in the system.

    * Requires token authentication.
    * Only admin users are able to access this view.
    """
    #  authentication_classes = (authentication.TokenAuthentication,)
    #  permission_classes = (permissions.IsAdminUser,)
    queryset = Inmueble.objects.all().order_by('-pk')
    serializer_class = InmuebleSerializador
    paginate_by = 10
    filter_class = InmuebleFilter


@api_view(['POST'])
@permission_classes((AllowAny,))
def publicar_inmueble(request):
    serialized = InmuebleSerializador(data=request.data)
    print(serialized)
    if serialized.is_valid():
        serialized.save()
        # Llamar al metodo para enviar email
        return JsonResponse({'mensaje': serialized.data}, status=status.HTTP_201_CREATED)
    else:
        return JsonResponse({'mensaje': serialized._errors}, status=status.HTTP_400_BAD_REQUEST)


# API para registrar inmueble version 1
class RegistrarInmueble(generics.ListCreateAPIView):
    serializer_class = InmuebleSerializador
    queryset = Inmueble.objects.all().order_by('-check_in')


# API EXPERIMENTAL PUT/POST/GET/DELETE
class InmuebleAPI(viewsets.ModelViewSet):
    queryset = Inmueble.objects.all().order_by('-pk')
    serializer_class = InmuebleSerializador
    filter_backends = [django_filters.rest_framework.DjangoFilterBackend, filters.SearchFilter]
    search_fields = ['titulo']

    def update(self, request, pk=None, **kwargs):
        inmueble = Inmueble.objects.get(id=pk)
        # 1 Actualizamos el inmueble
        instance = self.get_object()
        serializer = InmuebleSerializador(instance=instance, data=request.data, partial=True)
        if serializer.is_valid(raise_exception=True):
            serializer.save()
            self.perform_update(serializer)

        #  2 Borramos las imagenes a ser borradas

        idsImagenes = request.data.get("idsImg")[1:-1].split(",")
        print(idsImagenes)
        if idsImagenes[0]:  # Si existen ids
            for idImg in idsImagenes:
                Imagen.objects.get(id=idImg).delete()
        # 3 Guardamos las nuevas imagenes
        print("Se van a guardar las nuevas imagenes")
        if request.FILES:
            print("Si hay imagenes")
            inmuebleImagenes_data = request.FILES
            for datos_imagen in inmuebleImagenes_data.values():
                # Llamar al metodo con marca de agua
                Imagen.objects.create(inmueble=inmueble, imagen=datos_imagen)

        # 4 Retornar el inmueble creado
        return Response(serializer.data)


def existe_predio(request, predio):
    get_object_or_404(Inmueble, predio=int(predio))
    return HttpResponse(request, "Existe el usuario")
