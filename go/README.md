# go

```bash
curl http://localhost:8080/ping

curl -i --data '{"email":"xyz12@gmail.com","password":"abcdefghijkd"}' \
-H "Content-Type: application/json" \
-X POST http://localhost:8000/account/signin

curl -i --data '{"email":"xyz12@gmail.com"}' \
-H "Content-Type: application/json" \
-X POST http://localhost:8000/account/reset

curl -i --data '{"email":"xyz12@gmail.com", "password":"password"}' \
-H "Content-Type: application/json" \
-X POST http://localhost:8000/account/register
```
