from django.contrib.auth import get_user_model
from django.http import HttpResponse, JsonResponse
from django.utils.encoding import force_text
from django.utils.http import urlsafe_base64_decode
from django.contrib.auth.models import User
from django.views.decorators.csrf import csrf_exempt


#  Activar usuario
@csrf_exempt
def activate(request, codigo):
    try:
        user = get_user_model().objects.get(codigo=codigo)
        user.is_active = True
        user.save()
        return JsonResponse({'estado': True}, status=201)

    except(TypeError, ValueError, OverflowError, User.DoesNotExist):
        return HttpResponse(status=301)
