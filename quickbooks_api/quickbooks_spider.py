import requests, json, re
from processors import get_auth_header, mysql_db
import pandas as pd
from datetime import datetime, timedelta




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

def get_company_info(auth_header, realm_id):
    url = 'https://sandbox-quickbooks.api.intuit.com/v3/company/{}/company_info'.format(realm_id)
    headers = {
        'Authorization': auth_header,
        'accept': 'application/json'
    }
    r = requests.get(url, headers=headers)
    return r.text

class customer_info(object):
    @staticmethod
    def get_customers(auth_header, realm_id):
        query = "SELECT * FROM Customer WHERE Balance > '0'"
        url = 'https://sandbox-quickbooks.api.intuit.com/v3/company/{}/query?query={}'.format(realm_id, query)
        headers = {
            'Authorization': auth_header,
            'accept': 'application/json'
        }
        r = requests.get(url, headers=headers)
        data = json.loads(r.text)
        data = data['QueryResponse']['Customer']
        df = filter_customers(data, word)
        return df

    @staticmethod
    def filter_customers(data, word):
        df = pd.DataFrame(data)
        df = df[df['CompanyName'].str.contains(word)==True]
        return df

class invoice_info(object):
    @staticmethod
    def get_invoices(url, auth_header, realm_id):
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
        data = invoice_info.process_invoices(data)
        return data

    @staticmethod
    def process_invoices(data):
        df = pd.DataFrame(data)
        #print df.columns
        df = invoice_info.filter_id(df) ### filter ids
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
    def filter_id(df):
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

class get_pdf(object):
    # pdf name: "<store_name HollisterLowe's>-<date 9.26.17>.pdf"
    @ staticmethod
    def get_attachable_ids(realm_id, auth_header):
        query = "SELECT * FROM Attachable"
        url = 'https://sandbox-quickbooks.api.intuit.com/v3/company/{}/query?query={}'.format(realm_id, query)
        headers = {
            'Authorization': auth_header,
            'accept': 'application/json'
        }
        r = requests.get(url, headers=headers)
        return r.text

    @staticmethod
    def get_attachable_files(realm_id, attachable_id):
        url = 'https://quickbooks.api.intuit.com/v3/company/{}/download/{}'.format(realm_id, attachable_id)

class email_sender(object):
    client_id = ''
    client_secret = ''

    @staticmethod
    def loop_clients(_list):
        for x in _list:
            print x

    @staticmethod
    def create_message():
        sender_address = 'ar@buildinginspired.com'
        sender_full_name = 'Inspired Renovation LLC'
        cc_address = 'benjie.hill@buildinginspired.com'

    @staticmethod
    def send_message():
        pass



def main():
    global exception_list
    global _customer_filter

    mode = 'development'
#    mode = 'production'

    conn, cur = mysql_db.connect()
    exception_list = []
    _customer_filter = 'Sushi'

    client_id, client_secret = mysql_db.secrets(cur, mode)
    refresh_token, realm_id = mysql_db.token(cur, mode)
    bearer = mysql_db.url(cur, 'bearer')
    access_token = get_access_token.refresh(refresh_token, bearer, client_id, client_secret)

    if mode == 'production':
        base_url = mysql_db.url(cur, 'accounting')
    else:
        base_url = mysql_db.url(cur, 'accountingSandbox')

    if access_token == None:
        return 'Update Refresh Token'
    else:
        auth_header = 'Bearer ' + access_token
        invoices_data = invoice_info.get_invoices(base_url, auth_header, realm_id)
#        #invoices_pdf = get_pdf.get_attachable_ids(realm_id, auth_header)
        
        email_sender.loop_clients(invoices_data)    
 
    conn.close()
  
main()

