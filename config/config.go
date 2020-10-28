package config

import (
	"database/sql"
	"errors"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
	"time"

	dbMysql "github.com/angelmendozacap/expense-app/db/mysql"
	"github.com/labstack/echo/v4"
)

// GetDBInstance returns a new DB instance
func GetDBInstance() (*sql.DB, error) {
	dbPort, err := stringToInt(os.Getenv("DB_PORT"), "3030")
	if err != nil {
		log.Fatal(err)
	}

	dbMaxOpen, err := stringToInt(os.Getenv("DB_MAXOPEN"), "0")
	if err != nil {
		log.Fatal(err)
	}

	dbMaxIdle, err := stringToInt(os.Getenv("DB_MAXIDLE"), "2")
	if err != nil {
		log.Fatal(err)
	}

	dbMaxAgeMins, err := stringToInt(os.Getenv("DB_MAXAGEMINS"), "0")
	if err != nil {
		log.Fatal(err)
	}

	conn := &dbMysql.Model{
		Database: os.Getenv("DB_DATABASE"),
		Engine:   os.Getenv("DB_CONNECTION"),
		Port:     dbPort,
		Password: os.Getenv("DB_PASSWORD"),
		User:     os.Getenv("DB_USERNAME"),
		Server:   os.Getenv("DB_HOST"),
	}

	dbConn, err := conn.NewConnection()
	if err != nil {
		return nil, err
	}

	dbConn.SetMaxOpenConns(dbMaxOpen)
	dbConn.SetMaxIdleConns(dbMaxIdle)
	dbConn.SetConnMaxLifetime(time.Duration(dbMaxAgeMins) * time.Minute)

	return dbConn, nil
}

// GetPort returns the app port
func GetPort() string {
	p := os.Getenv("APP_PORT")
	if "" == p {
		p = "3030"
	}

	return fmt.Sprintf(":%s", p)
}

// EchoServerTimeout defines the timeout
func EchoServerTimeout(e *echo.Echo) {
	timeout, err := stringToInt(os.Getenv("ROUTES_SERVER_TIMEOUT_MINS"), "4")
	if err != nil {
		log.Fatal(err)
	}
	e.Server.ReadTimeout = time.Duration(timeout) * time.Minute
	e.Server.WriteTimeout = time.Duration(timeout) * time.Minute
}

// EchoAllowOrigins returns a list of origins that may access to the resource
func EchoAllowOrigins() []string {
	origins := os.Getenv("SERVER_ALLOW_ORIGINS")
	if origins == "" {
		return []string{"*"}
	}

	originsSlice := strings.Split(origins, ",")

	if len(originsSlice) == 0 {
		log.Fatal("At least one origin must be defined")
	}

	return originsSlice
}

func stringToInt(strValue, optValue string) (int, error) {
	if strValue == "" {
		strValue = optValue
	}

	intValue, err := strconv.Atoi(strValue)
	if err != nil {
		return 0, errors.New("Cannot convert DB port string to integer")
	}

	return intValue, nil
}
