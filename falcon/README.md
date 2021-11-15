# falcon

```bash
jwt
register
signin
signout
password reset
email confirmation
bcrypt
change password table
signin table
postgres table
testing falcon
rate limiting apu python
install pytest

curl --data '{"email":"xyz","password":"xyz"}' \
-H "Content-Type: application/json" \
-X POST http://192.168.33.10:3001/signin

curl -i --data '{"email":"xyz","password":"xyz"}' \
-H "Content-Type: application/json" \
-X POST http://192.168.33.10:3001/register

curl -i --data '{"email":"xyz@gmail.com","password":"xyz"}' \
-H "Content-Type: application/json" \
-X POST http://192.168.33.10:3001/register

curl -i --data '{"email":"xyz@gmail.com","password":"abcdefghijkd"}' \
-H "Content-Type: application/json" \
-X POST http://192.168.33.10:3001/register

curl -i --data '{"email":"xyz@gmail.com","password":"abcdefghijkd"}' \
-H "Content-Type: application/json" \
-X POST http://192.168.33.10:3001/signin

curl -i --data '{"email":"xyz1@gmail.com","password":"abcdefghijkd"}' \
-H "Content-Type: application/json" \
-X POST http://192.168.33.10:3001/signin

curl -i --data '{"email":"xyz12@gmail.com","password":"abcdefghijkd"}' \
-H "Content-Type: application/json" \
-X POST http://192.168.33.10:3001/register

docker-compose exec postgres psql -h postgres -U postgres

curl -i --data '{"email":"xyz1@gmail.com","password":"abcdefghijkd"}' \
-H "Content-Type: application/json" \
-X POST http://192.168.33.10:3001/signin

curl -i --data '{"email":"xyz12@gmail.com","password":"bcdefghijkd"}' \
-H "Content-Type: application/json" \
-X POST http://192.168.33.10:3001/register

curl -i --data '{"email":"xyz1@gmail.com","password":"cdefghijkd"}' \
-H "Content-Type: application/json" \
-X POST http://192.168.1.10:3001/signi
```
