from django.http import JsonResponse
from rest_framework import authentication, permissions, generics, status
from rest_framework.decorators import api_view, permission_classes
from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework.permissions import AllowAny
from rest_framework.viewsets import ModelViewSet

from apps.inmuebles.filtros import InmuebleFilter
from apps.inmuebles.models import Inmueble
from apps.inmuebles.serializers import InmuebleSerializador


class ListaInmuebles(generics.ListAPIView):
    """
    View to list all users in the system.

    * Requires token authentication.
    * Only admin users are able to access this view.
    """
    #  authentication_classes = (authentication.TokenAuthentication,)
    #  permission_classes = (permissions.IsAdminUser,)
    queryset = Inmueble.objects.all()
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
        return JsonResponse({'mensaje':serialized.data}, status=status.HTTP_201_CREATED)
    else:
        return JsonResponse({'mensaje': serialized._errors}, status=status.HTTP_400_BAD_REQUEST)


class Upload(generics.ListCreateAPIView):
    serializer_class = InmuebleSerializador
    queryset = Inmueble.objects.all()
