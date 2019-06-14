from django.core.files import File
from rest_framework import  serializers

from apps.inmuebles.models import Inmueble, Imagen


class ImagenSerializer(serializers.ModelSerializer):
    class Meta:
        model = Imagen
        fields = ('imagen',)


# Clase serializada para la tabla inmueble
class InmuebleSerializador(serializers.ModelSerializer):
    inmuebleImagenes = ImagenSerializer(many=True, read_only=True)

    class Meta:
        model = Inmueble
        fields = '__all__'

    def create(self, validated_data):
        inmuebleImagenes_data = self.context.get('view').request.FILES
        print("Esto ", inmuebleImagenes_data)
        inmueble = Inmueble.objects.create(**validated_data)
        for datos_imagen in inmuebleImagenes_data.values():
            print(datos_imagen)
            # Llamar al metodo con marca de agua
            #ruta_imagen = handle_uploaded_file(datos_imagen, inmueble.usuario)
            Imagen.objects.create(inmueble=inmueble, imagen=datos_imagen)
        return inmueble


def handle_uploaded_file(f,user):
    import uuid
    path = 'media/{}/{}{}'.format(user.cedulaRuc, f, uuid.uuid4())
    with open(path, 'wb+') as destination:
        for chunk in f.chunks():
            destination.write(chunk)
        return path