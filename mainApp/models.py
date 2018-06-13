from django.db import models
from django.contrib.postgres.operations import CreateExtension

# Create your models here.


class Migration(migrations.Migration):

    operations = [CreateExtension("postgis")]
