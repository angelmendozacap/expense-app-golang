package main

import (
	"github.com/angelmendozacap/expense-app/config"
	"github.com/angelmendozacap/expense-app/pkg/http/web/routes"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func initSetup() *echo.Echo {
	e := echo.New()
	config.EchoServerTimeout(e)

	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	e.Static("/static", "./ui/static")
	e.Renderer = newTmpl

	db := newConnection()

	routes.AdminRoutes(e, db)

	return e
}
