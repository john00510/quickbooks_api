from __future__ import unicode_literals
from django.db import models


    
class urls(models.Model):
    name = models.CharField(max_length=200,  primary_key=True)
    value = models.CharField(max_length=200, default='')
    def __str__(self):
        return self.value

class scopes(models.Model):
    name = models.CharField(max_length=200,  primary_key=True)
    value = models.CharField(max_length=200, default='')
    def __str__(self):
        return self.value

class tokens(models.Model):
    name = models.CharField(max_length=200,  primary_key=True)
    access_token = models.TextField(default='')
    refresh_token = models.TextField(default='')
    realm_id = models.CharField(max_length=200, default='')
    def __str__(self):
        return self.value

class secrets(models.Model):
    name = models.CharField(max_length=200, primary_key=True)
    client_id = models.TextField(default='')
    client_secret = models.TextField(default='')

