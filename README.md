*This project has been created as part of the 42 curriculum by <lkoc>*

# Inception: Docker Infrastructure Project

## Project Description
[cite_start]The primary goal of this system administration project is to build a robust, small-scale infrastructure using Docker and Docker Compose[cite: 479]. [cite_start]The environment virtualizes three distinct services running in separate, dedicated containers: an NGINX web server to handle secure HTTPS traffic, a WordPress installation running on PHP-FPM for content management, and a MariaDB instance serving as the database backend[cite: 358, 359, 360, 479]. [cite_start]The entire architecture relies on an internal Docker network for secure container-to-container communication and utilizes Docker volumes to ensure long-term data persistence[cite: 361, 362, 365, 479].

---

## Architectural & Design Choices

**Virtual Machines vs Docker Containers**
[cite_start]Virtual Machines emulate a complete hardware stack and require a full guest Operating System, making them resource-heavy and slow to boot[cite: 486]. Docker containers, on the other hand, share the host system's kernel, providing process-level isolation. [cite_start]This makes containers significantly more lightweight, allowing them to start almost instantly while consuming a fraction of the CPU and RAM[cite: 486].

**Secrets vs Environment Variables**
[cite_start]Environment variables are easy to configure and useful for general settings like domain names, but they can be exposed if the container's environment is inspected[cite: 487]. [cite_start]Docker Secrets provide a much higher level of security for sensitive data (like database passwords) by mounting them as temporary, encrypted files inside the container's memory rather than exposing them as plain text variables[cite: 487].

**Docker Network vs Host Network**
[cite_start]Using the host network bridges the container directly to the host machine's interfaces, removing network isolation[cite: 488]. This project implements a custom Docker bridge network, which isolates the services from the outside world. [cite_start]Only the NGINX container exposes a port to the host, while WordPress and MariaDB communicate securely over the internal DNS without being accessible from the public internet[cite: 488].

**Docker Volumes vs Bind Mounts**
[cite_start]Bind mounts rely on the specific directory structure of the host machine, mapping a host folder directly into the container[cite: 489]. [cite_start]Docker named volumes are fully managed by the Docker daemon, making them more portable, secure, and easier to back up[cite: 489]. [cite_start]In this architecture, persistent data is routed to `/home/lkoc/data` using named volumes to ensure database entries and website files survive container restarts[cite: 364].

---

## Instructions

**Prerequisites**
[cite_start]You need Docker, Docker Compose, and Make installed on your system[cite: 480]. [cite_start]Ensure that your local hosts file redirects `lkoc.42.fr` to your local IP[cite: 384, 385].

**Deployment**
[cite_start]Navigate to the root directory where the `Makefile` is located and execute the following command to build the images and start the infrastructure in the background[cite: 480]:
`make`

**Shutdown**
[cite_start]To safely stop the containers and remove the networks, run[cite: 480]:
`make down`

---

## Resources & AI Usage
**Official Documentation:**
* Docker & Docker Compose Docs: docs.docker.com
* NGINX Documentation: nginx.org/en/docs
* MariaDB Knowledge Base: mariadb.com/kb

**AI Tools Usage:**
[cite_start]During the development of this project, AI (Large Language Models) was used as an interactive learning assistant[cite: 481]. [cite_start]Specifically, AI was prompted to explain the differences between Docker volumes and bind mounts, to assist in debugging NGINX SSL certificate generation errors, and to review the shell scripts (`entrypoint.sh`) for infinite loops or bad practices[cite: 308, 315, 481]. [cite_start]All generated concepts were manually verified, tested, and rewritten to ensure full comprehension and compliance with the subject rules[cite: 311, 315].