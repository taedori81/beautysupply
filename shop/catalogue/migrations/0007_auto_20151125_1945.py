# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
import oscar.core.validators
import django.core.validators


class Migration(migrations.Migration):

    dependencies = [
        ('catalogue', '0006_auto_20151028_2341'),
    ]

    operations = [
        migrations.AlterField(
            model_name='productattribute',
            name='code',
            field=models.SlugField(verbose_name='Code', validators=[django.core.validators.RegexValidator(message="Code can only contain the letters a-z, A-Z, digits, and underscores, and can't start with a digit.", regex='^[a-zA-Z_][0-9a-zA-Z_]*$'), oscar.core.validators.non_python_keyword], max_length=128),
        ),
    ]
