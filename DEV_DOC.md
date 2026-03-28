*This project has been created as part of the 42 curriculum by <lkoc>*

# Developer Documentation

## Requirements

-   Docker
-   Docker Compose
-   Make

---

## Setup

Before you start, you need a `.env` file in the `srcs` folder. This file holds all the passwords and domain names. Use gitignore file to prevent pushing this file to your git repository.

Below are the required variables:

**Database (MariaDB):**
* `DB_NAME` - Name of the WordPress database.
* `DB_USER` - Username for the database (not root).
* `DB_PASSWORD` - Password for the database user.
* `DB_ROOT_PASSWORD` - Password for the MariaDB root user.
* `DB_HOST` - Internal hostname of the database container (mariadb).

**WordPress:**
* `WP_TITLE` - The title of your website.
* `WP_URL` - The full URL (https://lkoc.42.fr).
* `WP_ADMIN_USER` - Admin login (Must NOT contain the word 'admin').
* `WP_ADMIN_PASSWORD` - Secure password for the admin.
* `WP_ADMIN_EMAIL` - Email address for the admin.
* `WP_USER_NAME` - Second user login.
* `WP_USER_PASSWORD` - Password for the second user.
* `WP_USER_EMAIL` - Email for the second user.

**System Settings:**
* `DOMAIN_NAME` - Your login domain (lkoc.42.fr).
* `DATA_PATH` - Path to persistent data on host (/home/lkoc/data).

---

## Building and Running
We use a `Makefile` to control Docker Compose.
* Build and start everything: `make` (This runs `docker compose up -d --build`)
* Stop and remove containers: `make down`
* Full clean (removes containers, networks, and volumes): `make clean`

---

## Data Storage (Volumes)
If you restart the containers, your data is safe. We use Docker named volumes linked to the host machine.
* Database files are saved in: `/home/lkoc/data/db`
* WordPress files are saved in: `/home/lkoc/data/wp`

---

## Useful Commands for Debugging
If something goes wrong, use these commands:

**Check Status:**
* `docker ps` - See if all containers are running and healthy.

**Check Logs (Errors):**
* `docker compose logs -f` - See live error messages from all services.
* `docker compose logs wordpress` - See logs only for the WordPress container.

**Go Inside a Container:**
* `docker exec -it mariadb sh` - Open a terminal inside the database to check files.
* `docker exec -it wordpress sh` - Open a terminal inside WordPress.

**Network & Volumes:**
* `docker network ls` - Check if the "inception" network exists.
* `docker network inspect inception` - See which containers are connected to the network.
* `docker volume ls` - Check if your "wp" and "db" volumes are created.
