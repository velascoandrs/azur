from abc import ABC

from rest_framework import serializers
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer

from apps.usuarios.helpers import enviar_email, generar_codigo
from apps.usuarios.models import User


class TokenObtainPairPatchedSerializer(TokenObtainPairSerializer):

    def to_representation(self, instance):
        r = super(TokenObtainPairPatchedSerializer, self).to_representation(instance)
        r.update({'user': self.user.email}, )
        return r


class UserSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)

    class Meta:
        model = User
        fields = ('id', 'cedulaRuc', 'telefono', 'email', 'tipo', 'password')

    def create(self, validated_data):
        user = super(UserSerializer, self).create(validated_data)
        user.set_password(validated_data['password'])
        user.is_active = False
        user.codigo = generar_codigo()  # Generar codigo de 6 caracteres para la activacion de la cuenta
        user.save()
        return user

