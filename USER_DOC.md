*This project has been created as part of the 42 curriculum by <lkoc>*

# User Documentation

## Overview
This project runs a website infrastructure using three main services:
* **WordPress** (The website engine)
* **NGINX** (The secure web server)
* **MariaDB** (The database)

Each service runs in its own isolated "container". These containers share a private network to communicate with each other safely.

---

## Available Services
Once the project is running, you can access:
* **Main Website:** https://lkoc.42.fr
* **Admin Panel:** https://lkoc.42.fr/wp-admin

---

## How to start it
To start the infrastructure:
1. Open your terminal.
2. Go to the root folder (where the `Makefile` is).
3. Run the command:
   `make`

This will build the images and start all services in the background.

---

## How to stop it
To stop and remove all containers, networks, and volumes, run:
`make down`

---

## Credentials
For security, no passwords are hardcoded. All logins, passwords, and database names are stored in the `.env` file located in the `srcs` folder.

---

## Checking Services
To see if your services are running correctly:
* `docker ps` – Lists all active containers.
* `docker compose logs -f` – Shows live logs and error messages.

---

## Verifying Security (HTTPS)
NGINX is set up to allow only secure connections (port 443). You can test this using:
* `curl -I http://lkoc.42.fr` – Connection should be refused.
* `curl -kI https://lkoc.42.fr` – Connection should be successful.

---

## Verifying the Database
To check the data inside MariaDB:
1. Enter the container: `docker exec -it mariadb sh`
2. Log in to the database: `mariadb -u root -p`
3. List databases: `SHOW DATABASES;`
4. Use WordPress DB: `USE wordpress;`
5. See tables: `SHOW TABLES;`
6. Exit: `exit`
