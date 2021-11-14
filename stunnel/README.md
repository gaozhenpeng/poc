# stunnel

```bash
openssl version
sudo apt-get update -y
sudo apt-get install -y stunnel

# stunnel
sudo su
cp /vagrant/certs/* /etc/stunnel
cd /etc/stunnel

cat > test.conf<<END
pid = /var/run/stunnel4/test.pid
output = /var/log/stunnel4/test.log
fips = no
sslVersion = TLSv1
socket = r:TCP_NODELAY=1
socket = l:TCP_NODELAY=1
debug = 7

[test-in]
client=no
cert = /etc/stunnel/test.pem
key = /etc/stunnel/test.key
CAfile = /etc/stunnel/ca-cert.pem
accept = 192.168.33.92:8323
connect = 127.0.0.1:8322

[test-out]
client=no
cert = /etc/stunnel/test.pem
key = /etc/stunnel/test.key
CAfile = /etc/stunnel/ca-cert.pem
accept = 192.168.33.92:8323
connect = 127.0.0.1:8322
END

systemctl restart stunnel4.service
systemctl status stunnel4.service

tail -f /var/log

nc -lv 127.0.0.1 8322
```
