package account

import (
	"fmt"
	"time"
	"github.com/gin-gonic/gin"
	"github.com/dgrijalva/jwt-go"
)

func AddRoutes(e *gin.Engine) {
	account := e.Group("/account")
	{
		account.POST("/signin", SignIn)
		account.POST("/register", Register)
		account.POST("/reset_password", ResetPassword)
		account.POST("/reset_password_confirm", ResetPasswordConfirm)
		account.POST("/update_password", UpdatePassword)
		account.POST("/delete", DeleteAccount)
	}
}

type Account struct {
	Email string `json:"email"`
	Password string `json:"password"`
}

type Claims struct {
	Email string `json:"email"`
	jwt.StandardClaims
}

// create jwt key used for signing
var jwtKey = []byte("generate_this_secret_key")

func SignIn(c *gin.Context) {
	var account Account
	c.BindJSON(&account)
	// find email
	// compare password
	// CheckPasswordHash(account.Password, hash)

	// generate jwt
	expirationTime := time.Now().Add(5 * time.Minute)
    claims := &Claims{
		Email: account.Email,
		StandardClaims: jwt.StandardClaims {
			// unix milliseconds
			ExpiresAt: expirationTime.Unix(),
		},
	}

	// declare token with algorithm used for signing
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)

	// create jwt string
	tokenString, _ := token.SignedString(jwtKey)
	fmt.Println(tokenString)
	// log err here

	c.JSON(200, gin.H{"token": tokenString})
}

func Register(c *gin.Context) {
	var account Account
	c.BindJSON(&account)

	hash, _ := HashPassword(account.Password)
	fmt.Println(hash)
	c.JSON(200, gin.H{"msg": "success"})
}

func ResetPassword(c *gin.Context) {
	var account Account
	c.BindJSON(&account.Email)
	c.JSON(200, gin.H{"msg": "Please check your email"})
}

func ResetPasswordConfirm(c *gin.Context) {
	var account Account
	c.BindJSON(&account.Password)
	c.JSON(200, gin.H{"msg": "Please signin again"})
}

func UpdatePassword(c *gin.Context) {
	var account Account
	c.BindJSON(&account.Password)
	c.JSON(200, gin.H{"msg": "Please signin again"})
}

func DeleteAccount(c *gin.Context) {
	var account Account
	c.BindJSON(&account.Email)
	c.JSON(200, gin.H{"msg": "Account deleted"})
}
