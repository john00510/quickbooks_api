from django.conf.urls import url, include
from django.contrib import admin

urlpatterns = [
    url(r'^quickbooks_api/', include('quickbooks_api.urls')),
    #url(r'https://appcenter.intuit.com/(.+)'), include('quickbooks_api.urls')),
    url(r'^admin/', admin.site.urls),
]
