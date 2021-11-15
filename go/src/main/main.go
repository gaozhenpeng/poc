package main

import (
    "github.com/gin-gonic/gin"

    "account"
)

func main () {
	e := gin.Default()

	account.AddRoutes(e)

    e.GET("/ping", Ping)

	e.Run(":8000")
}

func Ping(c *gin.Context) {
	c.JSON(200, gin.H{"msg": "pong"})
}

