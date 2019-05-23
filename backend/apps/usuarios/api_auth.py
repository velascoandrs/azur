from django.http import JsonResponse
from pytz import unicode
from rest_framework import status
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.response import Response
from rest_framework.views import APIView

from apps.usuarios.helpers import enviar_email
from apps.usuarios.serializers import UserSerializer


class ObtenerUsuario(APIView):
    permission_classes = (IsAuthenticated,)

    def get(self, request, format=None):
        content = {
            'id': unicode(request.user.id),
            'email': unicode(request.user),  # `django.contrib.auth.User` instance.
            'cedulaRuc': unicode(request.user.cedulaRuc),
            'telefono': unicode(request.user.telefono),
            'tipo': unicode(request.user.tipo.id),
        }
        return Response(content)


@api_view(['POST'])
@permission_classes((AllowAny,))
def create_user(request):
    serialized = UserSerializer(data=request.data)
    if serialized.is_valid():
        serialized.save()
        # Llamar al metodo para enviar email
        enviar_email(request, serialized.data.get('id'), serialized.data.get('cedulaRuc'), serialized.data.get('email'))
        return JsonResponse({'mensaje':serialized.data}, status=status.HTTP_201_CREATED)
    else:
        return JsonResponse({'mensaje': serialized._errors}, status=status.HTTP_400_BAD_REQUEST)
