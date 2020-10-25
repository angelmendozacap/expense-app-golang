DROP DATABASE IF EXISTS expense_app;

CREATE DATABASE IF NOT EXISTS expense_app CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE expense_app;

CREATE TABLE categories (
    id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name varchar(100) NOT NULL,
    color varchar(7) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT NOW(),
    updated_at DATETIME,
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO categories (name, color) VALUES
(LOWER('food'), '#DE1F59'),
(LOWER('home'), '#DE1FAA'),
(LOWER('clothing'), '#B01FDE'),
(LOWER('games'), '#681FDE'),
(LOWER('travels'), '#1FAADE');

CREATE TABLE expenses (
    id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    category_id INTEGER NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    date DATE NOT NULL,
    user_id INTEGER NOT NULL,
    created_at DATETIME NOT NULL DEFAULT NOW(),
    updated_at DATETIME,
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO expenses (title, category_id, amount, date, user_id) VALUES
('prueba', 3, 12.40, '2020-03-21', 5),
('starbucks', 1, 60.00, '2020-03-21', 5),
('Regalo de cumpleaños mamá', 2, 1200.00, '2020-03-22', 5),
('Nintendo Switch', 4, 4600.00, '2020-03-26', 5),
('Viaje a Nueva York', 5, 20000.00, '2020-01-25', 5),
('Chocolates Ferrero', 1, 140.00, '2020-03-27', 5),
('sdsdsd', 1, 2323.00, '2020-04-03', 5),
('sadas', 1, 232.00, '2020-04-03', 5),
('sadas', 3, 11.00, '2020-04-03', 5),
('sdsd', 5, 23.00, '2020-04-03', 5),
('sdsd', 5, 23.00, '2020-04-03', 5),
('Chilis', 1, 300.00, '2020-01-01', 5),
('juego de Halo', 4, 1100.00, '2020-04-04', 5),
('Uñas', 3, 200.00, '2020-04-09', 6),
('pastillas para la tos', 2, 21.00, '2020-06-06', 5),
('Ropa nueva', 3, 300.00, '2020-06-04', 5),
('juego Nintendo', 2, 200.00, '2020-07-12', 5);

CREATE TABLE users (
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password CHAR(60) NOT NULL,
    photo VARCHAR(300),
    created_at DATETIME NOT NULL,
    updated_at DATETIME,
    is_active BOOLEAN NOT NULL DEFAULT TRUE
);

ALTER TABLE users ADD CONSTRAINT users_uq_email UNIQUE (email);

INSERT INTO users (name, email, password, created_at) VALUES (
    'Alice Jones',
    'alice@example.com',
    '$2a$12$Z6l.CHyOXGnsHo5rK1zi8eLHa.TtSYdpWIhSWwiMkX0ffKzOtxSEm',
    '2018-12-23 17:25:22'
);

ALTER TABLE snippets ADD CONSTRAINT snippets_fk_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE;
