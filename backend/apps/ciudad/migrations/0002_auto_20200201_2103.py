# Generated by Django 2.2.2 on 2020-02-02 02:03

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ciudad', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='ciudad',
            name='lat',
            field=models.CharField(max_length=30),
        ),
        migrations.AlterField(
            model_name='ciudad',
            name='lng',
            field=models.CharField(max_length=30),
        ),
    ]