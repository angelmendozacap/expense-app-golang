DROP DATABASE IF EXISTS expense_app;

CREATE DATABASE IF NOT EXISTS expense_app CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE expense_app;

CREATE TABLE roles (
    id INTEGER UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at DATETIME NOT NULL,
    updated_at DATETIME
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE roles ADD CONSTRAINT roles_uq_name UNIQUE (name);

INSERT INTO roles (name, created_at) VALUES
(UPPER('admin'), UTC_TIMESTAMP()),
(UPPER('user'), UTC_TIMESTAMP());

CREATE TABLE users (
    id INTEGER UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    role_id INTEGER UNSIGNED DEFAULT 1,
    password CHAR(60) NOT NULL,
    photo VARCHAR(300),
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at DATETIME NOT NULL,
    updated_at DATETIME
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE users ADD CONSTRAINT users_uq_email UNIQUE (email);
ALTER TABLE users ADD CONSTRAINT users_fk_role_id FOREIGN KEY (role_id) REFERENCES roles (id) ON DELETE SET NULL ON UPDATE CASCADE;

INSERT INTO users (name, email, password, created_at) VALUES (
    'Alice Jones',
    'alice@example.com',
    '$2a$12$Z6l.CHyOXGnsHo5rK1zi8eLHa.TtSYdpWIhSWwiMkX0ffKzOtxSEm',
    UTC_TIMESTAMP()
);

CREATE TABLE categories (
    id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name varchar(100) NOT NULL,
    color varchar(7) NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE categories ADD CONSTRAINT categories_uq_name UNIQUE (name);

INSERT INTO categories (name, color, created_at) VALUES
(LOWER('food'), '#DE1F59', UTC_TIMESTAMP()),
(LOWER('home'), '#DE1FAA', UTC_TIMESTAMP()),
(LOWER('clothing'), '#B01FDE', UTC_TIMESTAMP()),
(LOWER('games'), '#681FDE', UTC_TIMESTAMP()),
(LOWER('travels'), '#1FAADE', UTC_TIMESTAMP());

CREATE TABLE expenses (
    id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    category_id INTEGER UNSIGNED,
    amount DECIMAL(10,2) NOT NULL,
    date DATE NOT NULL,
    user_id INTEGER UNSIGNED NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


ALTER TABLE expenses ADD CONSTRAINT expenses_fk_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE expenses ADD CONSTRAINT expenses_fk_category_id FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE SET NULL ON UPDATE CASCADE;

INSERT INTO expenses (title, category_id, amount, date, user_id, created_at) VALUES
('prueba', 3, 12.40, '2020-03-21', 1, UTC_TIMESTAMP()),
('starbucks', 1, 60.00, '2020-03-21', 1, UTC_TIMESTAMP()),
('Regalo de cumpleaños mamá', 2, 1200.00, '2020-03-22', 1, UTC_TIMESTAMP()),
('Nintendo Switch', 4, 4600.00, '2020-03-26', 1, UTC_TIMESTAMP()),
('Viaje a Nueva York', 5, 20000.00, '2020-01-25', 1, UTC_TIMESTAMP()),
('Chocolates Ferrero', 1, 140.00, '2020-03-27', 1, UTC_TIMESTAMP()),
('sdsdsd', 1, 2323.00, '2020-04-03', 1, UTC_TIMESTAMP()),
('sadas', 1, 232.00, '2020-04-03', 1, UTC_TIMESTAMP()),
('sadas', 3, 11.00, '2020-04-03', 1, UTC_TIMESTAMP()),
('sdsd', 5, 23.00, '2020-04-03', 1, UTC_TIMESTAMP()),
('sdsd', 5, 23.00, '2020-04-03', 1, UTC_TIMESTAMP()),
('Chilis', 1, 300.00, '2020-01-01', 1, UTC_TIMESTAMP()),
('juego de Halo', 4, 1100.00, '2020-04-04', 1, UTC_TIMESTAMP()),
('Uñas', 3, 200.00, '2020-04-09', 1, UTC_TIMESTAMP()),
('pastillas para la tos', 2, 21.00, '2020-06-06', 1, UTC_TIMESTAMP()),
('Ropa nueva', 3, 300.00, '2020-06-04', 1, UTC_TIMESTAMP()),
('juego Nintendo', 2, 200.00, '2020-07-12', 1, UTC_TIMESTAMP());
