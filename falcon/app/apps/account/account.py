import falcon
from datetime import datetime
from .models import db, Account
from ..database import create_database



# email password expected

class Register:
    def on_post(self, req, resp):
        email = req.media.get('email')
        passw = req.media.get('password')
        account = Account(email=email, password=passw)
        account.validate()
        if account.errors:
            resp.media = {'error': account.errors}
            return
        account.password = Account.hash_password(account.password)
        account.save()
        # create confirm token
        # background job email send
        resp.media = {'message': 'Please check your email for a confirmation link.'}

class SignIn:
    def on_post(self, req, resp):
        email = req.media.get('email')
        passw = req.media.get('password')
        resp.media = {'message': 'Invalid email or password'}
        # device ip
        try:
            account = Account.get(Account.email == email)
            if not account.verify_password(passw): return
        except:
            return
        # get token
        resp.media = {'token': 'sample_token'}



# token expected

class ConfirmEmail:
    def on_get(self, req):
        token = req.media.get('token')
        try:
            # fix bug if token is empty
            account = Account.get(Account.confirm_token == token)
        except:
            resp.media = {'message': 'Invalid token.'}
            return
        account.confirmed = datetime.now()
        account.save()
        resp.media = {'message': 'Email confirmed successfully'}

class RequestResetPassword:
    def on_get(self, req, resp):
        email = req.media.get('email')
        resp.media = {'message': 'Please check your email for a reset link.'}
        try:
            account = Account.get(Account.email == email)
        except:
            return
        # send email with reset token

class ResetPassword:
    def on_get(self, req, resp):
        token = req.media.get('token')
        # find reset token for account
        # send email with temporary passsword
        # save account with temporary password
        resp.media = {'message': 'Please check your email for a temporary password.'}

class UpdatePassword:
    def on_post(self, req, resp):
        # get jwt in headers
        old_pass = req.media.get('old_password')
        new_pass = req.media.get('new_password')
        # save account with password
        resp.media = {'message': 'Password updated.'}



def run(api):
    create_database('account')
    db.connect()
    db.create_tables([Account])

    # add routes
    api.add_route('/rgstr', Register())
    api.add_route('/cmail', ConfirmEmail())
    api.add_route('/signi', SignIn())
    api.add_route('/rpass', RequestResetPassword())
    api.add_route('/reset', ResetPassword())
    api.add_route('/upass', UpdatePassword())
