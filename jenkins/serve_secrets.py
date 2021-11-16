import requests
import os
import re
from http.server import HTTPServer, BaseHTTPRequestHandler
import json


JENKINS_URL = os.environ['JENKINS_URL']
USERNAME    = os.environ['JENKINS_USER']
PASSWORD    = os.environ['JENKINS_PASS']

# access login page
jar = requests.cookies.RequestsCookieJar()
ses = requests.Session()
r = ses.get(f'{JENKINS_URL}/login', cookies=jar)

# login
data = {'j_username': USERNAME, 'j_password': PASSWORD, 'from': '', 'Submit': 'Sign+in'}
r = ses.post(f'{JENKINS_URL}/j_spring_security_check', data=data, cookies=jar)

# get crumb
def get_crumb():
    r = ses.get(f'{JENKINS_URL}/crumbIssuer/api/json')
    return r.json()['crumb']


# get each secrets for jenkins slave
slaves = ['slave']
secrets = {}

for slave in slaves:
    # get secret from master
    crumb = get_crumb()
    print(crumb)
    headers = {'Jenkins-Crumb': crumb}
    r = ses.get(f'{JENKINS_URL}/computer/{slave}', headers=headers)

    secret = re.search(f'{slave}\/jenkins-agent.jnlp -secret (.*) -workDir', r.text).group(1)
    secrets[slave] = secret


class HTTPRequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(json.dumps(secrets).encode('utf-8'))

print('Serving at 8102')
httpd = HTTPServer(('0.0.0.0', 8102), HTTPRequestHandler)
httpd.serve_forever()
