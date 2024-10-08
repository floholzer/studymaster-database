-- Erstelle die StudyMaster-Datenbank
CREATE DATABASE studymaster;
\c studymaster;

-- Tabelle für Benutzer mit is_admin-Feld
CREATE TABLE IF NOT EXISTS users (
                                     id SERIAL PRIMARY KEY,
                                     username VARCHAR(255) UNIQUE NOT NULL,
                                     email VARCHAR(255) UNIQUE NOT NULL,
                                     password VARCHAR(255) NOT NULL,
                                     first_name VARCHAR(255),
                                     last_name VARCHAR(255),
                                     is_admin BOOLEAN DEFAULT FALSE,
                                     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabelle für Aufgaben (Tasks)
CREATE TABLE IF NOT EXISTS tasks (
                                     id SERIAL PRIMARY KEY,
                                     user_id INT REFERENCES users(id) ON DELETE CASCADE,
                                     title VARCHAR(255) NOT NULL,
                                     description TEXT,
                                     due_date DATE,
                                     status VARCHAR(50) DEFAULT 'open',
                                     priority VARCHAR(50) DEFAULT 'medium',
                                     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabelle für Fortschritt (Progress)
CREATE TABLE IF NOT EXISTS progress (
                                        id SERIAL PRIMARY KEY,
                                        user_id INT REFERENCES users(id) ON DELETE CASCADE,
                                        task_id INT REFERENCES tasks(id) ON DELETE CASCADE,
                                        progress_percentage DECIMAL(5, 2) DEFAULT 0,
                                        points_earned INT DEFAULT 0,
                                        level INT DEFAULT 1,
                                        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabelle für Badges (Belohnungen)
CREATE TABLE IF NOT EXISTS badges (
                                      id SERIAL PRIMARY KEY,
                                      name VARCHAR(255) NOT NULL,
                                      description TEXT,
                                      points_required INT NOT NULL
);

-- Tabelle für Benutzer-Badges (verliehene Badges)
CREATE TABLE IF NOT EXISTS user_badges (
                                           id SERIAL PRIMARY KEY,
                                           user_id INT REFERENCES users(id) ON DELETE CASCADE,
                                           badge_id INT REFERENCES badges(id) ON DELETE CASCADE,
                                           awarded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabelle für User Sessions (Session Management)
CREATE TABLE IF NOT EXISTS user_sessions (
                                             session_id VARCHAR(255) PRIMARY KEY,
                                             user_id INT REFERENCES users(id) ON DELETE CASCADE,
                                             creation_time TIMESTAMP NOT NULL,
                                             expiry_time TIMESTAMP NOT NULL
);

-- Beispiel-Daten für Benutzer mit is_admin-Feld
INSERT INTO users (username, email, password, first_name, last_name, is_admin)
VALUES
    ('luisa', 'luisa@example.com', 'hashed_password_1', 'Luisa', 'Colon', FALSE),
    ('ismail', 'ismail@example.com', 'hashed_password_2', 'Ismail', 'Southern', FALSE),
    ('kory', 'kory@example.com', 'hashed_password_3', 'Kory', 'Morley', FALSE);

-- Beispiel-Daten für Aufgaben
INSERT INTO tasks (user_id, title, description, due_date, status, priority)
VALUES
    (1, 'Study for Math Exam', 'Prepare chapters 1-5 for the exam', '2024-09-30', 'open', 'high'),
    (2, 'Finish Project Report', 'Complete the final report for the software project', '2024-10-10', 'in progress', 'medium'),
    (3, 'Read History Book', 'Read chapters 4-6 of the history book', '2024-10-05', 'open', 'low');

-- Beispiel-Daten für Fortschritt
INSERT INTO progress (user_id, task_id, progress_percentage, points_earned, level)
VALUES
    (1, 1, 50.00, 10, 1),
    (2, 2, 75.00, 20, 2),
    (3, 3, 30.00, 5, 1);

-- Beispiel-Daten für Badges
INSERT INTO badges (name, description, points_required)
VALUES
    ('Beginner', 'Awarded for earning 10 points', 10),
    ('Intermediate', 'Awarded for earning 50 points', 50),
    ('Expert', 'Awarded for earning 100 points', 100);

-- Beispiel-Daten für Benutzer-Badges
INSERT INTO user_badges (user_id, badge_id, awarded_at)
VALUES
    (1, 1, CURRENT_TIMESTAMP),
    (2, 1, CURRENT_TIMESTAMP),
    (2, 2, CURRENT_TIMESTAMP);
