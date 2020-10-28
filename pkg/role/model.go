package role

import "time"

// Model role
type Model struct {
	ID        uint       `json:"id"`
	Name      string     `json:"name"`
	IsActive  bool       `json:"is_active"`
	CreatedAt *time.Time `json:"created_at"`
	UpdatedAt *time.Time `json:"updated_at"`
}

// Models roles
type Models []*Model

// Storage methods
type Storage interface {
	GetAll() (Models, error)
	GetByID(id uint) (*Model, error)
}
