import re
import bcrypt
from datetime import datetime
from peewee import Model, PostgresqlDatabase, CharField, DateTimeField, \
    BooleanField, ForeignKeyField

db = PostgresqlDatabase('account', user='postgres', password='postgres', \
                         host='postgres')

class BaseModel(Model):
    class Meta:
        database = db

class Account(BaseModel):
    email         = CharField(unique=True)
    password      = CharField()
    created       = DateTimeField(default=datetime.now())
    confirmed     = DateTimeField(null=True)
    confirm_token = CharField(null=True)
    deactivated   = DateTimeField(null=True)

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.errors = []

    EMAIL_REGEX    = re.compile(r"[0-9a-zA-Z.]*@[a-zA-Z.]*")
    PASSWORD_REGEX = re.compile(r"[a-z]{8,}")

    def validate(self):
        if not self.EMAIL_REGEX.match(self.email):
            self.errors.append('Email is not valid.')
        try:
            Account.get(Account.email == self.email)
            self.errors.append('Email already exists.')
        except Account.DoesNotExist:
            pass
        if not self.PASSWORD_REGEX.match(self.password):
            self.errors.append('Password is not valid.')

    def verify_password(self, plain_password):
        return bcrypt.checkpw(plain_password, self.password)

    def hash_password(plain_password):
        # change log_rounds parameter for hashing complexity
        return bcrypt.hashpw(plain_password, bcrypt.gensalt())

class Activity(BaseModel):
    account = ForeignKeyField(Account, backref='activity')
    ip      = CharField()
    device  = CharField()
    created = DateTimeField(default=datetime.now())
