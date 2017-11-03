import requests, json, random, re, base64, time, os
from datetime import datetime, timedelta
import pandas as pd
from urllib import urlencode
import MySQLdb as mdb


database = None

class mysql_db(object):
    @staticmethod
    def connect():
        conn = mdb.connect(
            user = 'quickbooks',
            passwd = 'quickbooks',
            db = 'quickbooks',
            host = 'localhost',
        )
        cur = conn.cursor()
        return conn, cur

    @staticmethod
    def secrets(cur, name):
        # development, production
        query = "SELECT client_id, client_secret FROM quickbooks_api_secrets WHERE name = '{}'".format(name)
        cur.execute(query)
        return cur.fetchone()

    @staticmethod
    def token(cur, name):
        query = "SELECT refresh_token, realm_id FROM quickbooks_api_tokens WHERE name = '{}'".format(name)
        cur.execute(query)
        return cur.fetchone()

    @staticmethod
    def url(cur, name):
        query = "SELECT value FROM quickbooks_api_urls WHERE name = '{}'".format(name)
        cur.execute(query)
        return cur.fetchone()[0]

class get_access_token(object):
    @staticmethod
    def refresh(refresh_token, bearer, client_id, client_secret):
        auth_header = get_auth_header(client_id, client_secret)
        access_token = get_access_token.request(auth_header, refresh_token, bearer)
        if access_token == 'invalid_grant':
            return None
        else:
            return access_token

    @staticmethod
    def request(auth_header, refresh_token, url):
        headers = {
            'Accept': 'application/json',
            'content-type': 'application/x-www-form-urlencoded',
            'Authorization': auth_header
        }
        payload = {
            'refresh_token': refresh_token,
            'grant_type': 'refresh_token'
        }
        r = requests.post(url, data=payload, headers=headers)
        data = json.loads(r.text)
        try:
            access_token = data['access_token']
            refresh_token_expires = data['x_refresh_token_expires_in']
            return access_token
        except:
            error = data['error']
            return error


def get_random_string(length):
    chars = 'abcdefghijklmnopqrstuvwxyz0123456789'
    line = [random.choice(chars) for x in range(length)]
    line = ''.join(line)
    return line  

def get_access_token(code, auth_header, redirect_uri, bearer):
    headers = {
        'Accept': 'application/json',
        'content-type': 'application/x-www-form-urlencoded',
        'Authorization': auth_header
    }
    payload = {
        'code': code,
        'redirect_uri': redirect_uri,
        'grant_type': 'authorization_code',
    }
    r = requests.post(bearer, data=payload, headers=headers)
    return r

class get_access_token_2(object):
    @staticmethod
    def refresh(refresh_token, bearer, client_id, client_secret):
        auth_header = get_auth_header(client_id, client_secret)
        access_token = get_access_token_2.request(auth_header, refresh_token, bearer)
        if access_token == 'invalid_grant':
            return None
        else:
            return access_token

    @staticmethod
    def request(auth_header, refresh_token, url):
        headers = {
            'Accept': 'application/json',
            'content-type': 'application/x-www-form-urlencoded',
            'Authorization': auth_header
        }
        payload = {
            'refresh_token': refresh_token,
            'grant_type': 'refresh_token'
        }
        r = requests.post(url, data=payload, headers=headers)
        data = json.loads(r.text)
        try:
            access_token = data['access_token']
            refresh_token_expires = data['x_refresh_token_expires_in']
            return access_token
        except:
            error = data['error']
            return error

class invoice_info(object):
    @staticmethod
    def get_invoices(url, auth_header, realm_id, exception_list, customer_filter):
        # DueDate, Balance, Id, CustomerRef.name
        date_today = datetime.now().date().strftime('%Y-%m-%d')
        query = "SELECT * FROM Invoice WHERE DueDate < '{}' AND Balance > '0'".format(date_today)
        url += '/v3/company/{}/query?query={}'.format(realm_id, query)
        headers = {
            'Authorization': auth_header,
            'accept': 'application/json'
        }
        r = requests.get(url, headers=headers)
        data = json.loads(r.text)
        data = data['QueryResponse']['Invoice']
        data = invoice_info.process_invoices(data, exception_list, customer_filter)
        return data

    @staticmethod
    def process_invoices(data, exception_list, _customer_filter):
        df = pd.DataFrame(data)
        #print df.columns
        df = invoice_info.filter_id(df, exception_list) ### filter ids
        df = df.apply(invoice_info.apply_invoices, axis=1)
        df = df[df['customer'].str.contains(_customer_filter)==False] ### filter customers
        data = invoice_info.group_invoices(df)
        return data

    @staticmethod
    def apply_invoices(row):
        # DueDate, Balance, CustomerRef, BillEmail, Id
        item = {}
        item['customer'] = row['CustomerRef']['name']
        item['id'] = row['Id']
        item['due_date'] = row['DueDate']
        item['balance'] = row['Balance']
        item['email'] = row['BillEmail']['Address']
        return pd.Series(item)

    @staticmethod
    def group_invoices(df):
        invoices = []
        for group, frame in df.groupby(['customer']):
            item = {}
            item['customer'] = group
            item['due_date'] = invoice_info.get_due_date(frame)
            item['email'] = invoice_info.get_email(frame)
            item['aging'] = invoice_info.get_aging(item['due_date'])
            item['notif_type'] = invoice_info.notification_type(item['aging'])
            item['invoice_ids'] = invoice_info.get_invoice_ids(frame)
            item['total_balance'] = invoice_info.get_total_balance(frame)
            invoices.append(item)

        return invoices

    @staticmethod
    def notification_type(aging):
        if aging >= 6:
            return '3rd_notice'
        elif aging >= 4:
            return '2nd_notice'
        else:
            return '1st_notice'

    @staticmethod
    def filter_id(df, exception_list):
        # values should be strings
        df = df[~df['Id'].isin(exception_list)]
        return df

    @staticmethod
    def get_aging(due_date):
        _timedelta = datetime.now().date() - datetime.strptime(due_date, '%Y-%m-%d').date()
        aging = re.findall(r'([0-9]+) days', str(_timedelta))
        return aging[0]

    @staticmethod
    def get_due_date(frame):
        due_date = frame['due_date']
        due_date = due_date.tolist()
        due_date.sort()
        return due_date[0]

    @staticmethod
    def get_email(frame):
        email = frame['email']
        email = email.tolist()
        return email[0]

    @staticmethod
    def get_invoice_ids(frame):
        ids = frame['id']
        ids = ids.tolist()
        return ids

    @staticmethod
    def get_total_balance(frame):
        balance = frame['balance']
        balance = balance.tolist()
        return sum(balance)

    @staticmethod
    def get_exception_list():
        _list = []
        return _list

def get_auth_header(client_id, client_secret):
    auth_header = base64.b64encode(bytearray(client_id + ':' + client_secret, 'utf-8')).decode()
    auth_header = 'Basic ' + auth_header
    return auth_header






