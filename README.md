# StudyMaster

StudyMaster ist eine Gamification-basierte Plattform für Zeitmanagement, die speziell für Studenten entwickelt wurde, um ihre Lernzeit zu planen und ihre Fortschritte zu verfolgen. Die Plattform verwendet Gamification-Elemente wie Punkte, Level und Badges, um Benutzer zu motivieren und ihre Produktivität zu steigern.

## Inhaltsverzeichnis

- [Funktionsübersicht](#funktionsübersicht)
- [Technologien](#technologien)
- [Setup](#setup)
- [Docker-Setup](#docker-setup)
- [Datenbankstruktur](#datenbankstruktur)
- [API-Endpunkte](#api-endpunkte)
- [Mitwirkende](#mitwirkende)
- [Lizenz](#lizenz)

## Funktionsübersicht

- **Benutzerregistrierung und Login:** Benutzer können sich registrieren und sicher in ihr Konto einloggen.
- **Aufgabenverwaltung:** Benutzer können Aufgaben erstellen, bearbeiten, löschen und als erledigt markieren.
- **Gamification-Elemente:** Nutzer sammeln Punkte und steigen in Leveln auf. Badges werden bei bestimmten Meilensteinen verliehen.
- **Fortschrittsdashboard:** Das Dashboard zeigt offene Aufgaben, Fortschritte und die verdienten Punkte.
- **Benachrichtigungen:** Benutzer erhalten im Programm Erinnerungen für bevorstehende Aufgaben und werden informiert, wenn sie neue Badges erhalten.

## Technologien

- **Frontend:** Vue.js
- **Backend:** Spring Boot
- **Datenbank:** PostgreSQL (mit Docker)
- **Containerisierung:** Docker
- **Testen:** ~ JUnit, Mockito, Vue Test Utils ~

## Setup

### Voraussetzungen

- [Node.js](https://nodejs.org/)
- [Java JDK 11+](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html)
- [Docker](https://www.docker.com/get-started)
- [PostgreSQL](https://www.postgresql.org/)

### Lokale Entwicklung

1. **Frontend (Vue.js) starten:**
   ```bash
   cd frontend
   npm install
   npm run serve
   ```

2. **Backend (Spring Boot) starten:**
   Stelle sicher, dass du eine PostgreSQL-Datenbank laufen hast (entweder lokal oder per Docker). Konfiguriere die Datenbankverbindung in der Datei `application.properties`.

   ```bash
   cd backend
   ./mvnw spring-boot:run
   ```

### Docker-Setup

1. Baue das Docker-Image für die PostgreSQL-Datenbank:
   ```bash
   docker build -t studymaster-db .
   ```

2. Starte den PostgreSQL-Datenbankcontainer:
   ```bash
   docker run -d --name studymaster-db-container -p 5432:5432 studymaster-db
   ```

3. Verifiziere, dass die Datenbank läuft und mit den Beispieltabellen und Daten initialisiert wurde.

## Datenbankstruktur

Die Datenbank besteht aus den folgenden Tabellen:

- **users:** Speichert Benutzerdaten (z. B. username, email, password, etc.).
- **tasks:** Speichert die Aufgaben der Benutzer (z. B. title, description, due_date, etc.).
- **progress:** Speichert den Fortschritt der Benutzer für jede Aufgabe.
- **badges:** Speichert die Badges, die Benutzer durch das Erreichen bestimmter Meilensteine erhalten können.
- **user_badges:** Verknüpft Benutzer mit den erhaltenen Badges.

### Beispiel für die Benutzer-Tabelle:

| id  | username | email              | first_name | last_name | created_at          |
| --- | -------- | ------------------ | ---------- | --------- | ------------------- |
| 1   | luisa    | luisa@example.com   | Luisa      | Colon     | 2024-09-01 12:00:00 |
| 2   | ismail   | ismail@example.com  | Ismail     | Southern  | 2024-09-01 12:05:00 |

## API-Endpunkte

### Benutzerverwaltung

- **POST /api/users/register** - Registriert einen neuen Benutzer.
- **POST /api/users/login** - Meldet einen Benutzer an.

### Aufgabenverwaltung

- **GET /api/tasks** - Ruft alle Aufgaben des angemeldeten Benutzers ab.
- **POST /api/tasks** - Erstellt eine neue Aufgabe.
- **PUT /api/tasks/:id** - Aktualisiert eine bestehende Aufgabe.
- **DELETE /api/tasks/:id** - Löscht eine Aufgabe.

### Fortschritt und Gamification

- **GET /api/progress** - Zeigt den aktuellen Fortschritt des Benutzers an.
- **GET /api/badges** - Zeigt alle verfügbaren Badges an.
- **GET /api/user_badges** - Zeigt die vom Benutzer erhaltenen Badges an.

## Mitwirkende

- **Flo** - wi22b090@technikum-wien.at
- **Jiri** - wi22b004@technikum-wien.at
- **Robert** - wi22b073@technikum-wien.at

## Lizenz

Dieses Projekt steht unter keiner Lizenz.


### **Wichtige Punkte:**
1. **Projektbeschreibung:** Die Einleitung erklärt das Ziel des Projekts und die Kernfunktionen (Gamification und Zeitmanagement).
2. **Technologien:** Die verwendeten Technologien (Vue.js, Spring Boot, PostgreSQL, Docker) werden beschrieben.
3. **Setup-Anleitung:** Es wird detailliert beschrieben, wie das Projekt lokal und in Docker eingerichtet werden kann.
4. **Datenbankstruktur:** Eine kurze Übersicht der Tabellen in der Datenbank.
5. **API-Endpunkte:** Die wichtigsten API-Routen für Benutzerverwaltung, Aufgaben und Fortschrittsverfolgung sind aufgeführt.
6. **Mitwirkende:** Das Team wird namentlich erwähnt.

