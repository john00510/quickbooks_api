"""
WSGI config for quickbooks_site project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/1.10/howto/deployment/wsgi/
"""

import os
#from os import path


from django.core.wsgi import get_wsgi_application

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "quickbooks_site.settings")
os.environ['HTTPS'] = 'on'

application = get_wsgi_application()



