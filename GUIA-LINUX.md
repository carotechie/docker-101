# 🐧 Guía de Docker para Linux

## Distribuciones Soportadas

- Ubuntu 20.04 LTS o superior
- Debian 10 o superior
- Fedora 35 o superior
- CentOS 8 / RHEL 8 o superior
- Arch Linux
- openSUSE

## Instalación por Distribución

### Ubuntu / Debian

```bash
# 1. Actualizar paquetes existentes
sudo apt-get update

# 2. Instalar dependencias
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# 3. Agregar la clave GPG oficial de Docker
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# 4. Configurar el repositorio
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 5. Instalar Docker Engine
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 6. Verificar instalación
sudo docker run hello-world
```

### Fedora

```bash
# 1. Instalar dependencias
sudo dnf -y install dnf-plugins-core

# 2. Agregar repositorio de Docker
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

# 3. Instalar Docker Engine
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 4. Iniciar Docker
sudo systemctl start docker
sudo systemctl enable docker

# 5. Verificar instalación
sudo docker run hello-world
```

### CentOS / RHEL

```bash
# 1. Instalar dependencias
sudo yum install -y yum-utils

# 2. Agregar repositorio de Docker
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# 3. Instalar Docker Engine
sudo yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 4. Iniciar Docker
sudo systemctl start docker
sudo systemctl enable docker

# 5. Verificar instalación
sudo docker run hello-world
```

### Arch Linux

```bash
# 1. Instalar Docker
sudo pacman -S docker docker-compose

# 2. Iniciar y habilitar Docker
sudo systemctl start docker.service
sudo systemctl enable docker.service

# 3. Verificar instalación
sudo docker run hello-world
```

## Configuración Post-Instalación

### Ejecutar Docker sin sudo (Recomendado)

```bash
# 1. Crear grupo docker (si no existe)
sudo groupadd docker

# 2. Agregar tu usuario al grupo docker
sudo usermod -aG docker $USER

# 3. Aplicar cambios de grupo
newgrp docker

# 4. Verificar que funciona sin sudo
docker run hello-world

# Si aún tienes problemas, cierra sesión y vuelve a iniciar
```

### Configurar Docker para iniciar al arranque

```bash
# Systemd (Ubuntu, Debian, Fedora, CentOS, Arch)
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# Verificar estado
sudo systemctl status docker
```

### Configurar límites de recursos

Edita `/etc/docker/daemon.json`:

```bash
sudo nano /etc/docker/daemon.json
```

Agrega:

```json
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  },
  "default-address-pools": [
    {
      "base": "172.17.0.0/16",
      "size": 24
    }
  ]
}
```

Reinicia Docker:

```bash
sudo systemctl restart docker
```

## Ejecutar el Proyecto de Ejemplo

```bash
# Navegar al directorio del proyecto
cd docker-101/website

# Construir la imagen
docker build -t mi-sitio-web .

# Ejecutar el contenedor
docker run -d -p 8080:80 --name mi-web mi-sitio-web

# Abrir en el navegador
xdg-open http://localhost:8080
# O en Firefox: firefox http://localhost:8080
# O en Chrome: google-chrome http://localhost:8080
```

## Comandos Esenciales

### Gestión de Contenedores

```bash
# Listar contenedores en ejecución
docker ps

# Listar todos los contenedores
docker ps -a

# Iniciar contenedor
docker start mi-web

# Detener contenedor
docker stop mi-web

# Reiniciar contenedor
docker restart mi-web

# Eliminar contenedor
docker rm mi-web

# Eliminar contenedor en ejecución (forzar)
docker rm -f mi-web

# Ver logs
docker logs mi-web

# Ver logs en tiempo real
docker logs -f mi-web

# Entrar al contenedor
docker exec -it mi-web sh

# Ver estadísticas de recursos
docker stats

# Inspeccionar contenedor
docker inspect mi-web
```

### Gestión de Imágenes

```bash
# Listar imágenes
docker images

# Construir imagen
docker build -t nombre-imagen:tag .

# Eliminar imagen
docker rmi nombre-imagen

# Descargar imagen
docker pull nginx:alpine

# Buscar imágenes en Docker Hub
docker search nginx

# Ver historial de una imagen
docker history nombre-imagen

# Etiquetar imagen
docker tag imagen-origen imagen-destino:tag
```

### Limpieza

```bash
# Eliminar contenedores detenidos
docker container prune

# Eliminar imágenes sin usar
docker image prune

# Eliminar volúmenes sin usar
docker volume prune

# Eliminar redes sin usar
docker network prune

# Limpiar todo (contenedores, imágenes, volúmenes, redes)
docker system prune -a --volumes

# Ver espacio usado
docker system df
```

## Alias Útiles para Bash/Zsh

Agrega estos alias a tu `~/.bashrc` o `~/.zshrc`:

```bash
# Alias de Docker
alias d='docker'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dex='docker exec -it'
alias dlog='docker logs -f'
alias dstop='docker stop $(docker ps -q)'
alias drm='docker rm $(docker ps -aq)'
alias dclean='docker system prune -af --volumes'
alias dstats='docker stats --no-stream'

# Funciones útiles
dsh() {
    docker exec -it $1 sh
}

dbash() {
    docker exec -it $1 bash
}

dbuild() {
    docker build -t $1 .
}

drun() {
    docker run -d -p $2:80 --name $1 $1
}

# Recargar configuración
source ~/.bashrc  # o source ~/.zshrc
```

## Solución de Problemas

### Error: "Cannot connect to the Docker daemon"

```bash
# Verificar si Docker está corriendo
sudo systemctl status docker

# Si no está corriendo, iniciarlo
sudo systemctl start docker

# Verificar que tu usuario está en el grupo docker
groups $USER

# Si no está, agregarlo
sudo usermod -aG docker $USER
newgrp docker
```

### Error: "permission denied while trying to connect to the Docker daemon socket"

```bash
# Opción 1: Agregar usuario al grupo docker
sudo usermod -aG docker $USER
newgrp docker

# Opción 2: Cambiar permisos del socket (temporal)
sudo chmod 666 /var/run/docker.sock

# Opción 3: Usar sudo (no recomendado)
sudo docker ps
```

### Docker consume mucho espacio en disco

```bash
# Ver uso de espacio
docker system df

# Limpiar recursos no utilizados
docker system prune -a --volumes

# Limpiar logs grandes
sudo sh -c "truncate -s 0 /var/lib/docker/containers/*/*-json.log"
```

### Problemas de red

```bash
# Reiniciar servicio de Docker
sudo systemctl restart docker

# Limpiar redes no utilizadas
docker network prune

# Verificar redes
docker network ls

# Inspeccionar red
docker network inspect bridge
```

### Contenedor no puede acceder a internet

```bash
# Verificar DNS
docker run --rm alpine ping -c 4 google.com

# Si falla, configurar DNS en /etc/docker/daemon.json
sudo nano /etc/docker/daemon.json

# Agregar:
{
  "dns": ["8.8.8.8", "8.8.4.4"]
}

# Reiniciar Docker
sudo systemctl restart docker
```

## Monitoreo y Logs

### Ver logs del sistema Docker

```bash
# Logs de Docker daemon
sudo journalctl -u docker.service

# Logs en tiempo real
sudo journalctl -u docker.service -f

# Logs de los últimos 100 mensajes
sudo journalctl -u docker.service -n 100
```

### Monitorear recursos

```bash
# Estadísticas en tiempo real
docker stats

# Estadísticas de un contenedor específico
docker stats mi-web

# Ver procesos dentro del contenedor
docker top mi-web

# Información detallada del sistema
docker info
```

## Seguridad

### Escanear imágenes en busca de vulnerabilidades

```bash
# Usando Docker Scout (integrado)
docker scout cves mi-sitio-web

# Usando Trivy
sudo apt-get install wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy

trivy image mi-sitio-web
```

### Ejecutar contenedores con usuario no root

```dockerfile
# En tu Dockerfile
FROM nginx:alpine
RUN addgroup -g 1000 appuser && adduser -D -u 1000 -G appuser appuser
USER appuser
```

### Limitar recursos del contenedor

```bash
# Limitar memoria
docker run -d --memory="512m" --name mi-web mi-sitio-web

# Limitar CPU
docker run -d --cpus="1.5" --name mi-web mi-sitio-web

# Limitar ambos
docker run -d --memory="512m" --cpus="1.5" --name mi-web mi-sitio-web
```

## Docker Compose

### Instalar Docker Compose (si no está incluido)

```bash
# Ya viene incluido con docker-compose-plugin
# Verificar versión
docker compose version

# Si necesitas la versión standalone
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

### Ejemplo de docker-compose.yml

```yaml
version: '3.8'

services:
  web:
    build: .
    ports:
      - "8080:80"
    restart: unless-stopped
    container_name: mi-web
```

```bash
# Iniciar servicios
docker compose up -d

# Detener servicios
docker compose down

# Ver logs
docker compose logs -f
```

## Recursos Adicionales

- [Documentación oficial de Docker](https://docs.docker.com/)
- [Docker Hub](https://hub.docker.com/)
- [Post-installation steps for Linux](https://docs.docker.com/engine/install/linux-postinstall/)

## Desinstalación

### Ubuntu / Debian

```bash
sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
```

### Fedora / CentOS

```bash
sudo dnf remove docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
```

---

**💡 Consejo**: Usa `htop` o `btop` para monitorear el uso de recursos de Docker en tiempo real.
