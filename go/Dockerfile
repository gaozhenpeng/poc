FROM golang:alpine AS build
RUN apk add git
RUN go get github.com/gin-gonic/gin \
           golang.org/x/crypto/bcrypt \
           github.com/dgrijalva/jwt-go \
           github.com/jinzhu/gorm
COPY src /go/src
RUN cd /go/src/main && GOOS=linux GOARCH=386 go build -o main .

FROM scratch
COPY --from=build /go/src/main/main /main
EXPOSE 8000
ENTRYPOINT ["/main"]

