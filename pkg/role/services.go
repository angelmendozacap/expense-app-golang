package role

import "errors"

// ErrIDNotFound error for IDNotFound
var ErrIDNotFound = errors.New("The role does not have an ID")

// Service role
type Service struct {
	storage Storage
}

// NewService role
func NewService(s Storage) *Service {
	return &Service{s}
}

// GetAll role
func (s *Service) GetAll() (Models, error) {
	return s.storage.GetAll()
}

// GetByID role
func (s *Service) GetByID(id uint) (*Model, error) {
	if id == 0 {
		return nil, ErrIDNotFound
	}

	return s.storage.GetByID(id)
}
