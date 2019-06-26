from django.contrib.sites.shortcuts import get_current_site
from django.core.mail import EmailMessage
from django.template.loader import render_to_string
import uuid

from apps.usuarios.models import User


def enviar_email(request, id_u):
    current_site = get_current_site(request)
    user = User.objects.get(id=id_u)
    print("deberia activarse")
    mail_subject = 'Activa tu cuenta.'
    message = render_to_string('acc_active_email.html', {
        'user': user.cedulaRuc,
        'domain': current_site.domain,
        'codigo': user.codigo,
    })
    to_email = user.email
    email = EmailMessage(
        mail_subject, message, to=[to_email]
    )
    email.content_subtype = "html"
    email.send()


def generar_codigo():
    return uuid.uuid4().hex[:7].upper()
