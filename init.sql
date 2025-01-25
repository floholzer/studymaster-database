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
                                     ects DECIMAL(3, 1) DEFAULT 0,  -- ECTS column
                                     points_per_submission INT DEFAULT 0,  -- Points per submission/chapter
                                     total_submissions INT DEFAULT 0,  -- Total submissions/chapters required
                                     completed_submissions INT DEFAULT 0,  -- Completed submissions/chapters
                                     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);
ALTER TABLE tasks ADD COLUMN points_earned INT DEFAULT 0;

-- Semesters Table
CREATE TABLE semesters (
                           id SERIAL PRIMARY KEY,
                           user_id INT REFERENCES users(id) ON DELETE CASCADE,
                           name VARCHAR(255) NOT NULL,
                           status VARCHAR(50) DEFAULT 'open', -- Werte: 'open', 'completed'
                           created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Subjects Table
CREATE TABLE subjects (
                          id SERIAL PRIMARY KEY,
                          semester_id INT REFERENCES semesters(id) ON DELETE CASCADE,
                          name VARCHAR(255) NOT NULL,
                          status VARCHAR(50) DEFAULT 'open', -- Werte: 'open', 'completed'
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE subjects ADD COLUMN award VARCHAR(50) DEFAULT 'Keinen';


-- Update Tasks Table to Link with Subjects
ALTER TABLE tasks ADD COLUMN subject_id INT REFERENCES subjects(id) ON DELETE CASCADE;
ALTER TABLE tasks ALTER COLUMN subject_id DROP NOT NULL;

ALTER TABLE subjects ADD COLUMN user_id BIGINT;

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
                                      points_required INT NOT NULL,
                                      badge_type VARCHAR(50) DEFAULT 'standard'  -- Badge type for categorizing badges (e.g., semester completion)
);

-- Tabelle für Benutzer-Badges (verliehene Badges)
CREATE TABLE IF NOT EXISTS user_badges (
                                           id SERIAL PRIMARY KEY,
                                           user_id INT REFERENCES users(id) ON DELETE CASCADE,
                                           badge_id INT REFERENCES badges(id) ON DELETE CASCADE,
                                           awarded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabelle für User Sessions (Session Management) - kann durch Spring Security ersetzt werden
CREATE TABLE IF NOT EXISTS user_sessions (
                                             session_id VARCHAR(255) PRIMARY KEY,
                                             user_id INT REFERENCES users(id) ON DELETE CASCADE,
                                             creation_time TIMESTAMP NOT NULL,
                                             expiry_time TIMESTAMP NOT NULL
);

-- Beispiel-Daten für Benutzer
INSERT INTO users (username, email, password, first_name, last_name, is_admin)
VALUES
    ('luisa', 'luisa@example.com', 'hashed_password_1', 'Luisa', 'Colon', FALSE),
    ('adminuser', 'admin@example.com', 'hashed_password_0', 'Admin', 'User', TRUE),
    ('ismail', 'ismail@example.com', 'hashed_password_2', 'Ismail', 'Southern', FALSE),
    ('kory', 'kory@example.com', 'hashed_password_3', 'Kory', 'Morley', FALSE),
    ('newuser','newuser@example.com','$2a$10$wR6GWKIVkzCjMI9ga254J.dIyjLLnJo9e2FDoVdXHspaXSrIFPvuu', 'New', 'User', FALSE);

-- Beispiel-Daten für Aufgaben
INSERT INTO tasks (user_id, title, description, due_date, status, priority, ects, points_per_submission, total_submissions, completed_submissions)
VALUES
    (1, 'Study for Math Exam', 'Prepare chapters 1-5 for the exam', '2024-09-30', 'open', 'high', 5.0, 10, 5, 0),
    (2, 'Finish Project Report', 'Complete the final report for the software project', '2024-10-10', 'in progress', 'medium', 2.5, 20, 3, 1),
    (3, 'Read History Book', 'Read chapters 4-6 of the history book', '2024-10-05', 'open', 'low', 3.0, 5, 3, 0);

-- Beispiel-Daten für Fortschritt
INSERT INTO progress (user_id, task_id, progress_percentage, points_earned, level)
VALUES
    (1, 1, 50.00, 10, 1),
    (2, 2, 75.00, 20, 2),
    (3, 3, 30.00, 5, 1);

-- Beispiel-Daten für Badges
INSERT INTO badges (name, description, points_required, badge_type)
VALUES
    ('Beginner', 'Awarded for earning 10 points', 10, 'standard'),
    ('Intermediate', 'Awarded for earning 50 points', 50, 'standard'),
    ('Expert', 'Awarded for earning 100 points', 100, 'standard'),
    ('Semester Completion', 'Awarded for completing a semester', 0, 'semester_completion');

-- Beispiel-Daten für Benutzer-Badges
INSERT INTO user_badges (user_id, badge_id, awarded_at)
VALUES
    (1, 1, CURRENT_TIMESTAMP),
    (2, 1, CURRENT_TIMESTAMP),
    (2, 2, CURRENT_TIMESTAMP);

-- Beispiel-Daten für User Sessions (optional)
INSERT INTO user_sessions (session_id, user_id, creation_time, expiry_time)
VALUES
    ('session_1', 1, NOW(), NOW() + INTERVAL '1 day'),
    ('session_2', 2, NOW(), NOW() + INTERVAL '1 day');
