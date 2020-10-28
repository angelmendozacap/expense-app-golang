package main

import (
	"log"

	"github.com/angelmendozacap/expense-app/config"
	"github.com/joho/godotenv"
)

func main() {
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}

	e := initSetup()

	log.Fatal(e.Start(config.GetPort()))
}
