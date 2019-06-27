from django.db import models
from apps.usuarios.models import User


# Tipo de inmueble
class TipoInmueble(models.Model):
    nombre_tipo = models.CharField(max_length=30, unique=True)


# Metodo de soporte que da formato a la ruta donde se almacenaran las imagenes de un inmueble
def user_directory_path(instance, filename):
    # file will be uploaded to MEDIA_ROOT/user_<id>/<filename>
    return 'user_{0}/{1}/{2}'.format(instance.inmueble.usuario.id, instance.inmueble.predio, filename)


#  Imagen
class Imagen(models.Model):
    imagen = models.ImageField(upload_to=user_directory_path)
    inmueble = models.ForeignKey('Inmueble', related_name='inmuebleImagenes', on_delete=models.CASCADE)


# Sector
class Sector(models.Model):
    nombre = models.CharField(max_length=30, null=False, blank=False)


# Inmueble
class Inmueble(models.Model):
    predio = models.IntegerField(unique=True, primary_key=True, null=False, blank=False, auto_created=False)
    ubicacion = models.CharField(max_length=50, null=False, blank=False)
    precio = models.DecimalField(null=False, blank=False, decimal_places=2, max_digits=10)
    titulo = models.CharField(null=False, blank=False, max_length=50)
    descripcion = models.CharField(null=False, blank=False, max_length=180)
    tipo = models.ForeignKey(TipoInmueble, on_delete=models.CASCADE, null=False, blank=False)
    usuario = models.ForeignKey(User, on_delete=models.CASCADE, null=False, blank=False)
    activo = models.BooleanField(default=True)
    sector = models.ForeignKey(Sector, related_name='sectorInmueble', on_delete=models.CASCADE)


