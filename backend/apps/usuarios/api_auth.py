from pytz import unicode
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView


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
