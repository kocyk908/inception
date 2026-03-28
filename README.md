*This project has been created as part of the 42 curriculum by <lkoc>*

# Inception

## Project Description
The goal of this project is to build a small, working infrastructure using Docker and Docker Compose.
It runs three services, each in its own container:

NGINX - handles secure traffic (HTTPS only)

WordPress + PHP-FPM - runs the website

MariaDB - stores all the data

All containers talk to each other over a dedicated Docker network.
Data is kept safe using Docker volumes, so nothing is lost when containers stop or restart.

---

## Design Choices

**Virtual Machines vs Docker Containers**
Virtual machines need a full operating system and take up a lot of resources.
Docker containers share the host system’s kernel, which makes them fast, lightweight, and easy to start.

| Virtual Machines      | Docker Containers      |
| ------------- | ------------- |
| Run a full OS inside | Share the host OS |
| Heavy on resources | Light and fast |
| Slow to start | Start in seconds |
| Strong isolation | Lighter isolation |

Containers are just easier to work with for this kind of project.

**Secrets vs Environment Variables**
Environment variables are easy to use but can be exposed.
Docker Secrets are more secure, they store sensitive data like passwords in temporary files that only the container can access.

**Docker Network vs Host Network**
Using the host network bridges the container directly to the host machine's interfaces, removing network isolation. This project uses a custom Docker network, so only NGINX is exposed to the outside. WordPress and MariaDB stay hidden and communicate internally.

**Docker Volumes vs Bind Mounts**
Bind mounts rely on the specific directory structure of the host machine, mapping a host folder directly into the container. Docker named volumes are fully managed by the Docker daemon, making them more portable, secure, and easier to back up. In this project, data is stored in `/home/lkoc/data` using named volumes to ensure database entries and website files survive container restarts.

---

## Instructions

**Requirements**
Make sure Docker, Docker Compose, and Make are installed.
Add `lkoc.42.fr` to your `/etc/hosts` file and point it to your local IP.

**Start the project**
Navigate to the root directory where the `Makefile` is located and execute either of following commands to build the Docker images and start the infrastructure in the background:
`make`
`docker compose up -d --build`

**Shutdown**
To stop and remove the containers and network use either:
`make down`
`docker compose down`

---

## Resources & AI Usage

**Documentation:**
* Docker & Docker Compose Docs: https://docs.docker.com
* NGINX Documentation: https://nginx.org/en/docs
* MariaDB Knowledge Base: https://mariadb.com/kb
* WordPress CLI documentation: https://developer.wordpress.org/cli/

**AI Tools Usage:**
I used AI tools to help learn and understand the concepts.
All generated code and ideas were tested, reviewed, and rewritten to make sure I fully understood them and followed the project rules.