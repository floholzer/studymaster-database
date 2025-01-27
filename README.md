# StudyMaster Database Setup

This project sets up a PostgreSQL database for the StudyMaster application. The database schema includes tables for users, tasks, semesters, subjects, progress, badges, user badges, and user sessions.

## Prerequisites

- Docker

## Getting Started

Open your Terminal and run the following Docker command to start the database:
```shell
docker run --name studymaster-db \
-p 5432:5432 \
-e POSTGRES_USER=postgres \
-e POSTGRES_PASSWORD=postgres \
-d floholzer/studymaster-database
```