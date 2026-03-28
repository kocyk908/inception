*This project has been created as part of the 42 curriculum by <lkoc>*

# Inception: Docker Infrastructure Project

## Project Description
The primary goal of this system administration project is to build a robust, small-scale infrastructure using Docker and Docker Compose. The environment virtualizes three distinct services running in separate, dedicated containers: an NGINX web server to handle secure HTTPS traffic, a WordPress installation running on PHP-FPM for content management, and a MariaDB instance serving as the database backend. The entire architecture relies on an internal Docker network for secure container-to-container communication and utilizes Docker volumes to ensure long-term data persistence.

---

## Architectural & Design Choices

**Virtual Machines vs Docker Containers**
Virtual Machines emulate a complete hardware stack and require a full guest Operating System, making them resource-heavy and slow to boot. Docker containers, on the other hand, share the host system's kernel, providing process-level isolation. This makes containers significantly more lightweight, allowing them to start almost instantly while consuming a fraction of the CPU and RAM.

**Secrets vs Environment Variables**
Environment variables are easy to configure and useful for general settings like domain names, but they can be exposed if the container's environment is inspected. Docker Secrets provide a much higher level of security for sensitive data (like database passwords) by mounting them as temporary, encrypted files inside the container's memory rather than exposing them as plain text variables.

**Docker Network vs Host Network**
Using the host network bridges the container directly to the host machine's interfaces, removing network isolation. This project implements a custom Docker bridge network, which isolates the services from the outside world. Only the NGINX container exposes a port to the host, while WordPress and MariaDB communicate securely over the internal DNS without being accessible from the public internet.

**Docker Volumes vs Bind Mounts**
Bind mounts rely on the specific directory structure of the host machine, mapping a host folder directly into the container. Docker named volumes are fully managed by the Docker daemon, making them more portable, secure, and easier to back up. In this architecture, persistent data is routed to `/home/lkoc/data` using named volumes to ensure database entries and website files survive container restarts.

---

## Instructions

**Prerequisites**
You need Docker, Docker Compose, and Make installed on your system. Ensure that your local hosts file redirects `lkoc.42.fr` to your local IP.

**Deployment**
Navigate to the root directory where the `Makefile` is located and execute the following command to build the images and start the infrastructure in the background:
make

**Shutdown**
To safely stop the containers and remove the networks, run:
make down

---

## Resources & AI Usage

**Official Documentation:**
* Docker & Docker Compose Docs: https://docs.docker.com
* NGINX Documentation: https://nginx.org/en/docs
* MariaDB Knowledge Base: https://mariadb.com/kb

**AI Tools Usage:**
During the development of this project, AI (Large Language Models) was used as an interactive learning assistant. Specifically, AI was prompted to explain the differences between Docker volumes and bind mounts, to assist in debugging NGINX SSL certificate generation errors, and to review the shell scripts (entrypoint.sh) for infinite loops or bad practices. All generated concepts were manually verified, tested, and rewritten to ensure full comprehension and compliance with the subject rules.