package routes

import (
	"database/sql"

	"github.com/angelmendozacap/expense-app/pkg/http/web/handlers"
	"github.com/labstack/echo/v4"
)

// AdminRoutes admin routes
func AdminRoutes(e *echo.Echo, db *sql.DB) {
	r := e.Group("/admin")

	h := handlers.NewAdminHandler(db)
	r.GET("/roles", h.ShowRoles)
}
