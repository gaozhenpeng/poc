# mail

```bash
# create self signed cert
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout mail.key -out mailcert.pem

# test ssl
git clone --depth 1 https://github.com/drwetter/testssl.sh.git
cd testssl.sh
./testssl.sh -t smtp 127.0.0.1:25
```
