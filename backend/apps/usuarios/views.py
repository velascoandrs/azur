from django.contrib.auth import get_user_model
from django.http import HttpResponse, JsonResponse
from django.contrib.sites.shortcuts import get_current_site
from django.utils.encoding import force_bytes, force_text
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from django.template.loader import render_to_string
from django.contrib.auth.models import User
from django.core.mail import EmailMessage
from django.views.decorators.csrf import csrf_exempt

from apps.usuarios.models import Tipo


def signup(request):
    if request.method == 'POST':
        validado = False
        if not validado:
            return HttpResponse(status=401)
        user = User()
        user.email = request.POST['email']
        user.cedula = request.POST['cedulaRuc']
        user.tipo = Tipo.objects.get(nombreTipo=request.POST['tipo'])
        user.telefono = request.POST['telefono']
        user.is_active = False
        user.save()
        current_site = get_current_site(request)
        mail_subject = 'Activa tu cuenta.'
        message = render_to_string('acc_active_email.html', {
                'user': user,
                'domain': current_site.domain,
                'uid': urlsafe_base64_encode(force_bytes(user.pk)),
            })
        to_email = user.email
        email = EmailMessage(
                        mail_subject, message, to=[to_email]
        )
        email.send()
        return JsonResponse({'estado': True})
    else:
        return HttpResponse(status=301)

@csrf_exempt
def activate(request, uidb64):
    try:
        uid = force_text(urlsafe_base64_decode(uidb64))
        print(uid)
        user = get_user_model().objects.get(id=int(uid))
        user.is_active = True
        user.save()
        return JsonResponse({'estado': True},status=201)

    except(TypeError, ValueError, OverflowError, User.DoesNotExist):
        return HttpResponse(status=301)
