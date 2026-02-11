# Docker 101 - Guía Práctica en Español 🐳

Bienvenido a Docker 101, una guía práctica paso a paso para aprender Docker desde cero.

## 📚 Contenido

1. [Instalación de Docker Desktop](#instalación-de-docker-desktop)
   - [Windows](#windows)
   - [macOS](#macos)
   - [Linux](#linux)
2. [Conceptos Básicos de Dockerfile](#conceptos-básicos-de-dockerfile)
3. [Proyecto Práctico: Sitio Web Animado](#proyecto-práctico-sitio-web-animado)
4. [Comandos Esenciales de Docker](#comandos-esenciales-de-docker)

---

## Instalación de Docker Desktop

### Windows

1. **Requisitos previos:**
   - Windows 10 64-bit: Pro, Enterprise o Education (Build 19041 o superior)
   - O Windows 11 64-bit
   - Habilitar WSL 2 (Windows Subsystem for Linux)

2. **Pasos de instalación:**
   ```powershell
   # Habilitar WSL 2 (ejecutar en PowerShell como Administrador)
   wsl --install
   ```

3. **Descargar Docker Desktop:**
   - Visita: https://www.docker.com/products/docker-desktop
   - Descarga Docker Desktop para Windows
   - Ejecuta el instalador `Docker Desktop Installer.exe`
   - Sigue el asistente de instalación
   - Reinicia tu computadora cuando se solicite

4. **Verificar instalación:**
   ```powershell
   docker --version
   docker run hello-world
   ```

### macOS

1. **Requisitos previos:**
   - macOS 11 o superior
   - Procesador Apple Silicon (M1/M2) o Intel

2. **Pasos de instalación:**
   ```bash
   # Opción 1: Descarga directa
   # Visita: https://www.docker.com/products/docker-desktop
   # Descarga Docker Desktop para Mac (Apple Silicon o Intel)
   
   # Opción 2: Usando Homebrew
   brew install --cask docker
   ```

3. **Instalar manualmente:**
   - Abre el archivo `.dmg` descargado
   - Arrastra Docker.app a la carpeta Aplicaciones
   - Abre Docker desde Aplicaciones
   - Autoriza los permisos cuando se solicite

4. **Verificar instalación:**
   ```bash
   docker --version
   docker run hello-world
   ```

### Linux

1. **Ubuntu/Debian:**
   ```bash
   # Actualizar paquetes
   sudo apt-get update
   
   # Instalar dependencias
   sudo apt-get install ca-certificates curl gnupg lsb-release
   
   # Agregar clave GPG oficial de Docker
   sudo mkdir -p /etc/apt/keyrings
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
   
   # Configurar repositorio
   echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   
   # Instalar Docker Engine
   sudo apt-get update
   sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
   
   # Agregar usuario al grupo docker (para no usar sudo)
   sudo usermod -aG docker $USER
   newgrp docker
   ```

2. **Fedora/RHEL/CentOS:**
   ```bash
   # Instalar dependencias
   sudo dnf -y install dnf-plugins-core
   
   # Agregar repositorio
   sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
   
   # Instalar Docker
   sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
   
   # Iniciar Docker
   sudo systemctl start docker
   sudo systemctl enable docker
   
   # Agregar usuario al grupo docker
   sudo usermod -aG docker $USER
   newgrp docker
   ```

3. **Verificar instalación:**
   ```bash
   docker --version
   docker run hello-world
   ```

---

## Conceptos Básicos de Dockerfile

Un Dockerfile es un archivo de texto que contiene instrucciones para construir una imagen de Docker.

### Estructura básica de un Dockerfile

```dockerfile
# Imagen base
FROM nginx:alpine

# Información del mantenedor
LABEL maintainer="tu-email@ejemplo.com"

# Directorio de trabajo
WORKDIR /usr/share/nginx/html

# Copiar archivos al contenedor
COPY . .

# Exponer puerto
EXPOSE 80

# Comando por defecto
CMD ["nginx", "-g", "daemon off;"]
```

### Instrucciones principales

- **FROM**: Define la imagen base
- **WORKDIR**: Establece el directorio de trabajo
- **COPY**: Copia archivos del host al contenedor
- **RUN**: Ejecuta comandos durante la construcción
- **EXPOSE**: Documenta qué puertos usa el contenedor
- **CMD**: Comando que se ejecuta al iniciar el contenedor
- **ENV**: Define variables de entorno

---

## Proyecto Práctico: Sitio Web Animado

Vamos a crear un sitio web con un cachorro y un pato felices para aprender Docker de forma práctica.

### Paso 1: Crear la estructura del proyecto

```bash
cd docker-101
mkdir website
cd website
```

### Paso 2: Crear el archivo HTML

Crea un archivo `index.html` (ver archivo en el proyecto)

### Paso 3: Crear el Dockerfile

Crea un archivo llamado `Dockerfile` (sin extensión):

```dockerfile
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

### Paso 4: Construir la imagen Docker

```bash
# Construir la imagen
docker build -t mi-sitio-web .

# Verificar que la imagen se creó
docker images
```

### Paso 5: Ejecutar el contenedor

```bash
# Ejecutar el contenedor
docker run -d -p 8080:80 --name mi-web mi-sitio-web

# Abrir en el navegador: http://localhost:8080
```

¡Deberías ver tu sitio web con el cachorro y el pato animados! 🐶🦆

---

## Comandos Esenciales de Docker

### 📋 Listar contenedores e imágenes

```bash
# Listar contenedores en ejecución
docker ps

# Listar TODOS los contenedores (incluyendo detenidos)
docker ps -a

# Listar imágenes
docker images

# Listar imágenes con detalles
docker images -a
```

### ▶️ Ejecutar contenedores

```bash
# Ejecutar contenedor en segundo plano (-d = detached)
docker run -d -p 8080:80 --name mi-contenedor nginx

# Ejecutar contenedor interactivo
docker run -it ubuntu bash

# Ejecutar con variables de entorno
docker run -e MI_VARIABLE=valor mi-imagen

# Ejecutar con volumen montado
docker run -v /ruta/local:/ruta/contenedor mi-imagen
```

### ⏹️ Detener y eliminar contenedores

```bash
# Detener un contenedor
docker stop mi-contenedor

# Detener todos los contenedores
docker stop $(docker ps -q)

# Eliminar un contenedor
docker rm mi-contenedor

# Eliminar un contenedor en ejecución (forzar)
docker rm -f mi-contenedor

# Eliminar todos los contenedores detenidos
docker container prune
```

### 🚪 Entrar a un contenedor

```bash
# Entrar a un contenedor en ejecución (bash)
docker exec -it mi-contenedor bash

# Si bash no está disponible, usar sh
docker exec -it mi-contenedor sh

# Ejecutar un comando específico
docker exec mi-contenedor ls -la

# Ver logs del contenedor
docker logs mi-contenedor

# Ver logs en tiempo real
docker logs -f mi-contenedor
```

### 🔍 Inspeccionar contenedores

```bash
# Ver información detallada del contenedor
docker inspect mi-contenedor

# Ver estadísticas de uso de recursos
docker stats mi-contenedor

# Ver procesos en ejecución dentro del contenedor
docker top mi-contenedor
```

### 🧹 Limpieza

```bash
# Eliminar imagen
docker rmi mi-imagen

# Eliminar imágenes sin usar
docker image prune

# Eliminar todo lo que no se está usando (contenedores, imágenes, redes, volúmenes)
docker system prune -a

# Ver espacio usado por Docker
docker system df
```

### 📦 Gestión de imágenes

```bash
# Construir imagen desde Dockerfile
docker build -t nombre-imagen:tag .

# Etiquetar imagen
docker tag imagen-origen imagen-destino:tag

# Subir imagen a Docker Hub
docker push usuario/imagen:tag

# Descargar imagen de Docker Hub
docker pull nginx:latest
```

---

## 🎯 Ejercicios Prácticos

### Ejercicio 1: Modificar el sitio web
1. Cambia los colores del sitio web
2. Reconstruye la imagen
3. Detén el contenedor anterior
4. Ejecuta el nuevo contenedor

### Ejercicio 2: Explorar un contenedor
1. Ejecuta un contenedor de Ubuntu
2. Entra al contenedor
3. Instala un paquete (ej: curl)
4. Sal del contenedor

### Ejercicio 3: Persistencia de datos
1. Crea un contenedor con un volumen
2. Escribe datos en el volumen
3. Elimina el contenedor
4. Crea un nuevo contenedor con el mismo volumen
5. Verifica que los datos persisten

---

## 📚 Recursos Adicionales

- [Documentación oficial de Docker](https://docs.docker.com/)
- [Docker Hub](https://hub.docker.com/)
- [Mejores prácticas para Dockerfile](https://docs.docker.com/develop/dev-best-practices/)

---

## 🤝 Contribuir

¿Encontraste un error o quieres mejorar esta guía? ¡Las contribuciones son bienvenidas!

---

**¡Feliz aprendizaje con Docker! 🐳**
