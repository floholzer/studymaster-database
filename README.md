# StudyMaster

StudyMaster is a gamification-based time management platform designed specifically for students to plan their study time and track their progress. The platform uses gamification elements such as points, levels, and badges to motivate users and increase their productivity.

## Table of Contents

- [Features Overview](#features-overview)
- [Technologies](#technologies)
- [Setup](#setup)
- [Docker Setup](#docker-setup)
- [Database Structure](#database-structure)
- [API Endpoints](#api-endpoints)
- [Contributors](#contributors)
- [License](#license)

## Features Overview

- **User Registration and Login:** Users can register and securely log into their accounts.
- **Task Management:** Users can create, edit, delete, and mark tasks as completed.
- **Gamification Elements:** Users earn points and level up. Badges are awarded at certain milestones.
- **Progress Dashboard:** The dashboard shows open tasks, progress, and earned points.
- **Notifications:** Users receive reminders for upcoming tasks and are notified when they earn new badges.

## Technologies

- **Frontend:** Vue.js
- **Backend:** Spring Boot
- **Database:** PostgreSQL (with Docker)
- **Containerization:** Docker
- **Testing:** JUnit, Mockito, Vue Test Utils

## Setup

### Prerequisites

- [Node.js](https://nodejs.org/)
- [Java JDK 11+](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html)
- [Docker](https://www.docker.com/get-started)
- [PostgreSQL](https://www.postgresql.org/)

### Local Development

1. **Start Frontend (Vue.js):**
   ```bash
   cd frontend
   npm install
   npm run serve
   ```

2. **Start Backend (Spring Boot):**
   Ensure you have a PostgreSQL database running (either locally or via Docker). Configure the database connection in the `application.properties` file.

   ```bash
   cd backend
   ./mvnw spring-boot:run
   ```

## Docker Setup

1. Build the Docker image for the PostgreSQL database:
   ```bash
   docker build -t studymaster-db .
   ```

2. Start the PostgreSQL database container:
   ```bash
   docker run -d --name studymaster-db-container -p 5432:5432 studymaster-db
   ```

3. Verify that the database is running and initialized with the sample tables and data.

## Database Structure

The database consists of the following tables:

- **users:** Stores user data (e.g., username, email, password, etc.).
- **tasks:** Stores user tasks (e.g., title, description, due_date, etc.).
- **progress:** Stores user progress for each task.
- **badges:** Stores badges that users can earn by reaching certain milestones.
- **user_badges:** Links users with the badges they have earned.

### Example of the Users Table:

| id  | username | email              | first_name | last_name | created_at          |
| --- | -------- | ------------------ | ---------- | --------- | ------------------- |
| 1   | luisa    | luisa@example.com  | Luisa      | Colon     | 2024-09-01 12:00:00 |
| 2   | ismail   | ismail@example.com | Ismail     | Southern  | 2024-09-01 12:05:00 |

## API Endpoints

### User Management

- **POST /api/users/register** - Registers a new user.
- **POST /api/users/login** - Logs in a user.

### Task Management

- **GET /api/tasks** - Retrieves all tasks for the logged-in user.
- **POST /api/tasks** - Creates a new task.
- **PUT /api/tasks/:id** - Updates an existing task.
- **DELETE /api/tasks/:id** - Deletes a task.

### Progress and Gamification

- **GET /api/progress** - Shows the current progress of the user.
- **GET /api/badges** - Shows all available badges.
- **GET /api/user_badges** - Shows the badges earned by the user.

## Contributors

- **Flo** - wi22b090@technikum-wien.at
- **Jiri** - wi22b004@technikum-wien.at
- **Robert** - wi22b073@technikum-wien.at

## License

This project is not licensed.

### **Important Points:**
1. **Project Description:** The introduction explains the project's goal and core features (gamification and time management).
2. **Technologies:** The technologies used (Vue.js, Spring Boot, PostgreSQL, Docker) are described.
3. **Setup Instructions:** Detailed instructions on how to set up the project locally and in Docker.
4. **Database Structure:** A brief overview of the tables in the database.
5. **API Endpoints:** The main API routes for user management, tasks, and progress tracking are listed.
6. **Contributors:** The team is mentioned by name.
```