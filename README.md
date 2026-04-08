*This project has been created as part of the 42 curriculum by lkoc*

# Inception

## Project Description
The goal of this project is to build a small, working infrastructure using Docker and Docker Compose.
It runs three services, each in its own container:

* NGINX - handles secure traffic (HTTPS only)

* WordPress + PHP-FPM - runs the website

* MariaDB - stores all the data

All containers talk to each other over a dedicated Docker network.
Data is kept safe using Docker volumes, so nothing is lost when containers stop or restart.

**Links:**
* Website: https://lkoc.42.fr
* Admin Panel: https://lkoc.42.fr/wp-admin

---

## Design Choices

**Virtual Machines vs Docker Containers**

Virtual machines need a full operating system and take up a lot of resources.
Docker containers share the host system’s kernel, which makes them fast, lightweight, and easy to start.

| Virtual Machines     | Docker Containers |
|----------------------|-------------------|
| Run a full OS inside | Share the host OS |
| Heavy on resources   | Light and fast    |
| Slow to start        | Start in seconds  |
| Strong isolation     | Lighter isolation |

Containers are just easier to work with for this kind of project.

----------------------

**Secrets vs Environment Variables**

Environment variables are easy to use but can be exposed if not handled carefully.
Docker Secrets are more secure, storing sensitive data in temporary memory files that only the container can access.

| Environment Variables | Docker Secrets                       |
|-----------------------|--------------------------------------|
| Stored in .env files  | Stored in encrypted files            |
| Easy to edit/inject   | Better for complex production setups |
| Can be exposed        | Not visible in container env         |

For this project, all sensitive data is securely managed through a `.env` file, which is excluded from Git via `.gitignore` to prevent leaks. This fulfills the security requirements without overcomplicating the infrastructure.

----------------------

**Docker Network vs Host Network**

Using the host network bridges the container directly to the host machine's interfaces, removing network isolation. This project uses a custom Docker network, so only NGINX is exposed to the outside. WordPress and MariaDB stay hidden and communicate internally.

| Custom Docker Network             | Host Network                           |
|-----------------------------------|----------------------------------------|
| Containers talk over internal DNS | Containers use host's network directly |
| More secure                       | Less isolation                         |
| Default setup                     | Bypasses Docker networking             |

A custom bridge network keeps things clean - only NGINX is exposed to the outside.

----------------------

**Docker Volumes vs Bind Mounts**

Bind mounts connect a container directly to a folder on the host machine. Docker volumes are managed by Docker itself, making them safer and easier to move. In this project, data is stored in `/home/lkoc/data` using named volumes to keep our database and website safe when containers restart.

| Docker Volumes        | Bind Mounts                    |
|-----------------------|--------------------------------|
| Managed by Docker     | Direct link to host folder     |
| Portable and safe     | Depends on host file structure |
| Better for production | Good for development           |

Named volumes store data in `/home/lkoc/data` on the host machine.

---

## Instructions

**Requirements**

Make sure all
* Docker,
* Docker Compose,
* Make

are installed.
Add `lkoc.42.fr` to your `/etc/hosts` file and point it to your local IP.

**Start the project**

Open your terminal, go to the folder with the `Makefile` and type:
* `make`

to build the Docker images and start the infrastructure in the background.

**Shutdown**

To stop and remove the containers and network use either:
* `make down`

---

## Resources & AI Usage

**Documentation:**
* Docker & Docker Compose Docs: https://docs.docker.com
* NGINX Documentation: https://nginx.org/en/docs
* MariaDB Knowledge Base: https://mariadb.com/kb
* WordPress CLI documentation: https://developer.wordpress.org/cli/

**AI Tools Usage:**

I used AI tools to help learn and understand the concepts and debug issues with container communication.
All generated code and ideas were tested, reviewed, and rewritten to make sure I fully understood them and followed the project rules.
