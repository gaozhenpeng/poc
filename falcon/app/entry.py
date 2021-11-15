import falcon
from apps.account import account


api = falcon.API()
account.run(api)
