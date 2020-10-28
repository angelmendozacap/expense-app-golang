package role

import (
	"database/sql"

	"github.com/angelmendozacap/expense-app/db/mysql"
)

var (
	mysqlGetAll  = "SELECT id, name, is_active, created_at, updated_at FROM roles"
	mysqlGetByID = mysqlGetAll + " WHERE id = ?"
)

// MySQL used for work with mySQL
type MySQL struct {
	db *sql.DB
}

// NewMySQL return a new pointer of MySQL
func NewMySQL(db *sql.DB) *MySQL {
	return &MySQL{db}
}

// GetAll mysql role
func (srv *MySQL) GetAll() (Models, error) {
	ms := make(Models, 0)

	stmt, err := srv.db.Prepare(mysqlGetAll)
	if err != nil {
		return nil, err
	}
	defer stmt.Close()

	rows, err := stmt.Query()
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	for rows.Next() {
		m, err := srv.scanRow(rows)
		if err != nil {
			return nil, err
		}

		ms = append(ms, m)
	}

	return ms, nil
}

// GetByID mysql role
func (srv *MySQL) GetByID(id uint) (*Model, error) {
	stmt, err := srv.db.Prepare(mysqlGetByID)
	if err != nil {
		return nil, err
	}
	defer stmt.Close()

	return srv.scanRow(stmt.QueryRow(id))
}

func (srv *MySQL) scanRow(s mysql.RowScanner) (*Model, error) {
	m := &Model{}

	if err := s.Scan(
		&m.ID,
		&m.Name,
		&m.IsActive,
		&m.CreatedAt,
		&m.UpdatedAt,
	); err != nil {
		return nil, err
	}

	return m, nil
}
