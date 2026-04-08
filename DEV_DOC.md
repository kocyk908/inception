*This project has been created as part of the 42 curriculum by <lkoc>*

# Developer Documentation

## 1. Setup from Scratch
To set up the environment, you need:
* **Prerequisites:** Docker, Docker Compose, and Make must be installed.
* **Configuration:** Create a `.env` file in the `srcs` folder.

Ensure passwords for the database and admin are defined in the `.env` file. (Do not push this file to Git!)

Below are the required variables:

**Database (MariaDB):**
* `DB_NAME` - Name of the WordPress database.
* `DB_USER` - Username for the database (not root).
* `DB_PW` - Password for the database user.
* `DB_ROOT_PW` - Password for the MariaDB root user.
* `DB_HOST` - Internal hostname of the database container (mariadb).
* `DB_PORT` - The internal port number on which the MariaDB server listens for incoming SQL connections.

**WordPress:**
* `WORDPRESS_TITLE` - The title of your website.
* `WORDPRESS_ADM` - Admin login (Must NOT contain the word 'admin').
* `WORDPRESS_ADM_PW` - Secure password for the admin.
* `WORDPRESS_ADM_EMAIL` - Email address for the admin.
* `WORDPRESS_USER` - Second user login.
* `WORDPRESS_USER_PW` - Password for the second user.
* `WORDPRESS_USER_EMAIL` - Email for the second user.

**System Settings:**
* `LOGIN` - Your 42 intra login.
* `DOMAIN` - Your login domain (user.42.fr).
* `DATA_PATH` - Path to persistent data on host (/home/lkoc/data).
* `NETWORK` - The dedicated Docker bridge network name.

## 2. Build and Launch
We use a `Makefile` as a shortcut for long Docker Compose commands.

**Start the infrastructure:**
* Command: `make`
* What it actually does: It runs `docker compose up -d --build` inside the `srcs` folder. This command reads your `docker-compose.yml`, builds the images from scratch, and starts the containers in the background.

**Stop the infrastructure:**
* Command: `make down`
* What it actually does: It runs `docker compose down`. This safely stops the running containers and removes the custom network.

## 3. Manage Containers and Volumes
Use these commands to manage the stack:
* `docker compose ps` – View status of containers.
* `docker compose logs -f` – See live error logs.
* `docker exec -it <name> sh` – Access a container's terminal.
* `docker volume ls` – List active volumes.

## 4. Data Storage and Persistence
All project data is stored on the host machine to ensure it is not lost:
* **Path:** `/home/lkoc/data/`
* **WordPress files:** Stored in the `WORDPRESS` volume.
* **Database files:** Stored in the `db` volume.

Even if you delete the containers using `make down`, the data stays safe in these folders. When you run `make` again, the website will load exactly as you left it.
