# Generated by Django 3.2.3 on 2021-08-10 21:34

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('main_app', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='question',
            name='answer',
            field=models.BooleanField(choices=[(True, 'True'), (False, 'False')]),
        ),
        migrations.AlterField(
            model_name='question',
            name='question',
            field=models.CharField(max_length=70),
        ),
    ]
