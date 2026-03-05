# Heriverse Docker

Instructions for building and running the Heriverse tool from container using Docker.

## Install Homebrew and dependencies (macOS)
If you don't have Homebrew, install it from the official page: https://brew.sh/

## Install Docker and Docker compose (macOS)

```bash
brew install docker
brew install docker-compose
```

## Docker engine (macOS)
You need a Docker daemon. Recommended options:

Colima (lightweight, no GUI):
```bash
brew install colima
colima start
```

Or Docker Desktop: https://www.docker.com/products/docker-desktop/

## 🔐 OpenSSL (Required for HTTPS)

This project uses self-signed SSL certificates to enable HTTPS locally via Nginx.

In order to generate the certificates, OpenSSL must be installed on your system.

---

### macOS

Install using Homebrew:

brew install openssl

Verify installation:

openssl version

---

### Linux

Ubuntu / Debian:
sudo apt update
sudo apt install openssl

Fedora:
sudo dnf install openssl

Arch Linux:
sudo pacman -S openssl

Verify:

openssl version

---

### Windows

Important: On Windows you must use Git Bash or WSL.
PowerShell and CMD are NOT supported.

Option 1 – Git Bash (Recommended)

1. Install Git for Windows:
   https://git-scm.com/download/win

2. Open Git Bash and verify:

   openssl version

(OpenSSL is included by default in Git Bash)

---

Option 2 – WSL (Windows Subsystem for Linux)

1. Install WSL:
   https://learn.microsoft.com/windows/wsl/install

2. Open your Linux distribution and run:

   sudo apt update
   sudo apt install openssl

3. Verify:

   openssl version

## First-time run (macOS-Linux-Windows)
Locate the Heriverse-docker folder
Run this only the first time you set up the container
(for windows run the scripts in git bash or in WSL):

### To generate local https certificates:

Run the script:
```bash
./generate-certs.sh
```

If the script fails, run this command in the terminal:
```bash 
mkdir -p certs && \
openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout mount/nginx/certs/localhost.key \
  -out mount/nginx/certs/localhost.crt \
  -subj "/C=IT/ST=Local/L=Local/O=Dev/OU=Dev/CN=localhost"
```

### Run this command to start Docker
```bash
docker-compose up --build -d
```
### To set up CouchDB:
Run the script:

```bash
./entrypoint.sh
```
If the script fails, run this command in the terminal:
```bash 
until curl -s http://127.0.0.1:5984 >/dev/null; do sleep 1; done; curl -u admin:admin -X POST http://127.0.0.1:5984/_cluster_setup -H "Content-Type: application/json" -d '{"action":"enable_single_node","username":"admin","password":"admin","bind_address":"0.0.0.0","port":5984}'; curl -u admin:admin -X POST http://127.0.0.1:5984/_cluster_setup -H "Content-Type: application/json" -d '{"action":"finish_cluster"}'; curl -u admin:admin http://127.0.0.1:5984/_cluster_setup

```

## Now the setup is complete and docker is running
To use Heriverse copy-paste the following link into your browser:
https://localhost/a/heriverse

## End docker containers session
```bash
docker-compose stop
```

## Start docker containers for future sessions
```bash
colima start
docker-compose up -d
```

## Default heriverse user
username: testuser 

password: testpassword

## CouchDB user
username: admin

password: admin

## Link

### Access Heriverse.
To use Heriverse copy-paste the following link into your browser:
https://localhost/a/heriverse

#### CouchDB
http://localhost/couchdb/_utils/

## File Uploads
All uploaded files are stored in the following directory:
/heriverse-server/uploads
