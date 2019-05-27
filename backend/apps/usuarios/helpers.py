from django.contrib.sites.shortcuts import get_current_site
from django.core.mail import EmailMessage
from django.template.loader import render_to_string
from django.utils.encoding import force_bytes
from django.utils.http import urlsafe_base64_encode


def enviar_email(request, pk, cedula, user_email):
    current_site = get_current_site(request)
    mail_subject = 'Activa tu cuenta.'
    message = render_to_string('acc_active_email.html', {
        'user': cedula,
        'domain': current_site.domain,
        'uid': urlsafe_base64_encode(force_bytes(cedula)),
    })
    to_email = user_email
    email = EmailMessage(
        mail_subject, message, to=[to_email]
    )
    email.send()
