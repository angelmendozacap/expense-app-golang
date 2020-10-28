package main

import (
	"database/sql"
	"log"

	"github.com/angelmendozacap/expense-app/config"
)

func newConnection() *sql.DB {
	db, err := config.GetDBInstance()
	if err != nil {
		log.Fatal(err.Error())
		return nil
	}

	return db
}
