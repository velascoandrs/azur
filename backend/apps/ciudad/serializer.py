from rest_framework import serializers

from apps.ciudad.models import Ciudad


class CiudadSerializer(serializers.ModelSerializer):
    class Meta:
        model = Ciudad
        fields = '__all__'
