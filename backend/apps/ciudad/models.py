from django.db import models


class Ciudad(models.Model):
    name = models.CharField(
        max_length=30,
        null=False,
        blank=False
    )
    country = models.CharField(
        max_length=30,
        null=False,
        blank=False,
    )
    lat = models.CharField(
        max_length=30,
        blank=False,
        null=False,
    )
    lng = models.CharField(
        max_length=30,
        blank=False,
        null=False,
    )
