CREATE DATABASE studymaster;
\c studymaster;

CREATE TABLE IF NOT EXISTS users (
   id serial PRIMARY KEY,
   first_name VARCHAR(255) NOT NULL,
   last_name VARCHAR(255) NOT NULL
);

INSERT INTO users(id, first_name, last_name)
VALUES 
   (1, 'Luisa', 'Colon'),
	(2, 'Ismail', 'Southern'),
	(3, 'Kory', 'Morley');