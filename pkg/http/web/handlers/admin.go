package handlers

import (
	"database/sql"
	"log"
	"net/http"

	"github.com/angelmendozacap/expense-app/pkg/role"
	"github.com/labstack/echo/v4"
)

// AdminHandler admin
type AdminHandler struct {
	DB *sql.DB
}

// NewAdminHandler admin
func NewAdminHandler(db *sql.DB) *AdminHandler {
	return &AdminHandler{db}
}

// ShowRoles admin
func (h *AdminHandler) ShowRoles(c echo.Context) error {
	storage := role.NewMySQL(h.DB)
	service := role.NewService(storage)
	roles, err := service.GetAll()
	if err != nil {
		log.Printf("error: cannot retrieve the data. AdminHandler ShowRoles: %v", err)
		return err
	}

	return c.Render(http.StatusOK, "roles.admin.tmpl", roles)
}
