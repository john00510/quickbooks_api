from django.conf.urls import url


from . import views

urlpatterns = [
    url(r'^$', views.index, name='index'),
    url(r'^connect_to_quickbooks/', views.connect_to_quickbooks, name='connect_to_quickbooks'),
    url(r'^get_code_handler/', views.get_code_handler, name='get_code_handler'),
    url(r'test/', views.__test, name='test')
]
