# Generated by Django 2.2.1 on 2019-05-26 23:31

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('inmuebles', '0002_auto_20190526_0013'),
    ]

    operations = [
        migrations.AddField(
            model_name='inmueble',
            name='activo',
            field=models.BooleanField(default=True),
        ),
        migrations.AddField(
            model_name='inmueble',
            name='titulo',
            field=models.CharField(default='Casa hermosa', max_length=50),
            preserve_default=False,
        ),
    ]