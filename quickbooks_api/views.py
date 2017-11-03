from django.shortcuts import render, redirect
from django.http import HttpResponse, HttpResponseBadRequest
from urllib import urlencode
from urlparse import urlparse
from .models import urls, scopes, tokens, secrets #, clients
from .processors import get_random_string, get_auth_header, get_access_token, get_access_token_2, invoice_info
import json


#mode = 'production'
mode = 'development'

client_id = list(secrets.objects.filter(pk=mode).values())[0]['client_id']
client_secret = list(secrets.objects.filter(pk=mode).values())[0]['client_secret']
scope = list(scopes.objects.filter(pk='accounting').values())[0]['value']
redirect_uri = list(urls.objects.filter(pk='redirect_uri').values())[0]['value']
bearer = list(urls.objects.filter(pk='bearer').values())[0]['value']
authorization = list(urls.objects.filter(pk='authorization').values())[0]['value']
auth_header = get_auth_header(client_id, client_secret)

def index(request):
    return render(request, 'quickbooks_api/index.html')

def connect_to_quickbooks(request):
    payload = {
        'client_id': client_id,
        'response_type': 'code',
        'scope': scope,
        'redirect_uri': redirect_uri,
        'state': get_random_string(50)
    }
    params = urlencode(payload)
    url = authorization
    url += '?' + params
    return redirect(url)

def get_code_handler(request):
    error = request.GET.get('error', None)
    state = request.GET.get('state', None)
    realm_id = request.GET.get('realmId', None)

    if error == 'access_denied':
        redirect('index')
    elif state == None:
        return HttpResponseBadRequest()
    #elif state_new != state:
    #    return HttpResponse('unathorized', code=401)
    else:
        code = request.GET.get('code')
        response = get_access_token(code, auth_header, redirect_uri, bearer)
        data = json.loads(response.text)
        refresh_token = data['refresh_token']
        access_token = data['access_token']

        tokens(name=mode, access_token=access_token, refresh_token=refresh_token, realm_id=realm_id).save()
        return redirect('/quickbooks_api/')
    #return HttpResponse(request)

def __test(request):
    if mode == 'production':
        base_url = list(urls.objects.filter(pk='accounting').values())[0]['value']
    else:
        base_url = list(urls.objects.filter(pk='accountingSandbox').values())[0]['value']

    exception_list = []
    customer_filter = 'sushi'

    refresh_token = list(tokens.objects.filter(pk=mode).values())[0]['refresh_token']
    realm_id = list(tokens.objects.filter(pk=mode).values())[0]['realm_id']
    access_token = get_access_token_2.refresh(refresh_token, bearer, client_id, client_secret)
    auth_header = 'Bearer ' + access_token
    invoice_data = invoice_info.get_invoices(base_url, auth_header, realm_id, exception_list, customer_filter)
    #return render(request, 'quickbooks_api/test.html')
    return HttpResponse(invoice_data)



