# 🐳 Referencia Rápida de Comandos Docker

## 📋 Tabla de Contenidos

- [Contenedores](#contenedores)
- [Imágenes](#imágenes)
- [Redes](#redes)
- [Volúmenes](#volúmenes)
- [Docker Compose](#docker-compose)
- [Sistema](#sistema)
- [Registro y Logs](#registro-y-logs)

---

## Contenedores

### Listar Contenedores

```bash
# Contenedores en ejecución
docker ps

# Todos los contenedores (incluyendo detenidos)
docker ps -a

# Solo IDs de contenedores
docker ps -q

# Últimos N contenedores creados
docker ps -n 5

# Contenedores con formato personalizado
docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"
```

### Ejecutar Contenedores

```bash
# Ejecutar en segundo plano
docker run -d nginx

# Con nombre personalizado
docker run -d --name mi-nginx nginx

# Mapear puertos (host:contenedor)
docker run -d -p 8080:80 nginx

# Mapear todos los puertos expuestos
docker run -d -P nginx

# Con variables de entorno
docker run -d -e MI_VAR=valor nginx

# Con múltiples variables
docker run -d -e VAR1=valor1 -e VAR2=valor2 nginx

# Modo interactivo con terminal
docker run -it ubuntu bash

# Eliminar automáticamente al salir
docker run --rm -it ubuntu bash

# Con límites de recursos
docker run -d --memory="512m" --cpus="1.5" nginx

# Con volumen montado
docker run -d -v /ruta/host:/ruta/contenedor nginx

# Con red personalizada
docker run -d --network mi-red nginx

# Reiniciar automáticamente
docker run -d --restart unless-stopped nginx
```

### Gestionar Contenedores

```bash
# Iniciar contenedor detenido
docker start mi-contenedor

# Detener contenedor
docker stop mi-contenedor

# Detener con timeout personalizado (segundos)
docker stop -t 30 mi-contenedor

# Reiniciar contenedor
docker restart mi-contenedor

# Pausar contenedor
docker pause mi-contenedor

# Reanudar contenedor pausado
docker unpause mi-contenedor

# Eliminar contenedor
docker rm mi-contenedor

# Eliminar contenedor en ejecución (forzar)
docker rm -f mi-contenedor

# Eliminar múltiples contenedores
docker rm contenedor1 contenedor2 contenedor3

# Eliminar todos los contenedores detenidos
docker container prune

# Detener todos los contenedores
docker stop $(docker ps -q)

# Eliminar todos los contenedores
docker rm $(docker ps -aq)
```

### Interactuar con Contenedores

```bash
# Ejecutar comando en contenedor
docker exec mi-contenedor ls -la

# Entrar al contenedor (bash)
docker exec -it mi-contenedor bash

# Entrar al contenedor (sh)
docker exec -it mi-contenedor sh

# Ejecutar como usuario específico
docker exec -u root -it mi-contenedor bash

# Ver logs
docker logs mi-contenedor

# Ver logs en tiempo real
docker logs -f mi-contenedor

# Ver últimas N líneas de logs
docker logs --tail 100 mi-contenedor

# Ver logs con timestamps
docker logs -t mi-contenedor

# Copiar archivos del host al contenedor
docker cp archivo.txt mi-contenedor:/ruta/destino/

# Copiar archivos del contenedor al host
docker cp mi-contenedor:/ruta/archivo.txt ./

# Ver procesos en el contenedor
docker top mi-contenedor

# Ver estadísticas de recursos
docker stats mi-contenedor

# Ver estadísticas de todos los contenedores
docker stats

# Inspeccionar contenedor (JSON)
docker inspect mi-contenedor

# Obtener IP del contenedor
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mi-contenedor

# Ver cambios en el sistema de archivos
docker diff mi-contenedor

# Crear imagen desde contenedor
docker commit mi-contenedor mi-nueva-imagen

# Exportar contenedor como tar
docker export mi-contenedor > contenedor.tar

# Importar contenedor desde tar
docker import contenedor.tar mi-imagen:tag
```

---

## Imágenes

### Listar y Buscar Imágenes

```bash
# Listar imágenes locales
docker images

# Listar todas las imágenes (incluyendo intermedias)
docker images -a

# Listar solo IDs de imágenes
docker images -q

# Buscar imágenes en Docker Hub
docker search nginx

# Buscar con filtro de estrellas
docker search --filter stars=100 nginx

# Buscar imágenes oficiales
docker search --filter is-official=true nginx
```

### Descargar y Construir Imágenes

```bash
# Descargar imagen
docker pull nginx

# Descargar versión específica
docker pull nginx:1.21

# Descargar imagen de plataforma específica
docker pull --platform linux/amd64 nginx

# Construir imagen desde Dockerfile
docker build -t mi-imagen .

# Construir con nombre y tag
docker build -t mi-imagen:v1.0 .

# Construir desde Dockerfile específico
docker build -f Dockerfile.prod -t mi-imagen .

# Construir sin usar caché
docker build --no-cache -t mi-imagen .

# Construir con argumentos
docker build --build-arg VERSION=1.0 -t mi-imagen .

# Construir y etiquetar múltiples tags
docker build -t mi-imagen:latest -t mi-imagen:v1.0 .
```

### Gestionar Imágenes

```bash
# Etiquetar imagen
docker tag imagen-origen imagen-destino:tag

# Eliminar imagen
docker rmi mi-imagen

# Eliminar imagen por ID
docker rmi abc123def456

# Eliminar múltiples imágenes
docker rmi imagen1 imagen2 imagen3

# Eliminar imágenes sin usar
docker image prune

# Eliminar todas las imágenes sin usar (incluyendo sin tag)
docker image prune -a

# Ver historial de capas de una imagen
docker history mi-imagen

# Inspeccionar imagen
docker inspect mi-imagen

# Guardar imagen en archivo tar
docker save -o mi-imagen.tar mi-imagen

# Cargar imagen desde archivo tar
docker load -i mi-imagen.tar

# Subir imagen a Docker Hub
docker push usuario/mi-imagen:tag
```

---

## Redes

### Listar y Crear Redes

```bash
# Listar redes
docker network ls

# Crear red bridge
docker network create mi-red

# Crear red con subnet específica
docker network create --subnet=172.18.0.0/16 mi-red

# Crear red con gateway
docker network create --gateway=172.18.0.1 --subnet=172.18.0.0/16 mi-red

# Inspeccionar red
docker network inspect mi-red

# Eliminar red
docker network rm mi-red

# Eliminar redes sin usar
docker network prune
```

### Conectar Contenedores a Redes

```bash
# Conectar contenedor a red
docker network connect mi-red mi-contenedor

# Desconectar contenedor de red
docker network disconnect mi-red mi-contenedor

# Ejecutar contenedor en red específica
docker run -d --network mi-red --name mi-contenedor nginx
```

---

## Volúmenes

### Gestionar Volúmenes

```bash
# Listar volúmenes
docker volume ls

# Crear volumen
docker volume create mi-volumen

# Inspeccionar volumen
docker volume inspect mi-volumen

# Eliminar volumen
docker volume rm mi-volumen

# Eliminar volúmenes sin usar
docker volume prune

# Eliminar todos los volúmenes sin usar (sin confirmación)
docker volume prune -f
```

### Usar Volúmenes

```bash
# Montar volumen nombrado
docker run -d -v mi-volumen:/ruta/contenedor nginx

# Montar directorio del host (bind mount)
docker run -d -v /ruta/host:/ruta/contenedor nginx

# Montar como solo lectura
docker run -d -v mi-volumen:/ruta/contenedor:ro nginx

# Usar sintaxis --mount (más explícita)
docker run -d --mount source=mi-volumen,target=/ruta/contenedor nginx

# Crear volumen anónimo
docker run -d -v /ruta/contenedor nginx
```

---

## Docker Compose

### Comandos Básicos

```bash
# Iniciar servicios
docker compose up

# Iniciar en segundo plano
docker compose up -d

# Construir imágenes antes de iniciar
docker compose up --build

# Detener servicios
docker compose down

# Detener y eliminar volúmenes
docker compose down -v

# Ver logs
docker compose logs

# Ver logs en tiempo real
docker compose logs -f

# Ver logs de servicio específico
docker compose logs -f web

# Listar contenedores
docker compose ps

# Ejecutar comando en servicio
docker compose exec web bash

# Construir servicios
docker compose build

# Construir sin caché
docker compose build --no-cache

# Reiniciar servicios
docker compose restart

# Pausar servicios
docker compose pause

# Reanudar servicios
docker compose unpause

# Ver configuración procesada
docker compose config
```

---

## Sistema

### Información del Sistema

```bash
# Información general de Docker
docker info

# Versión de Docker
docker version

# Ver espacio usado por Docker
docker system df

# Ver espacio detallado
docker system df -v

# Eventos en tiempo real
docker events

# Eventos con filtros
docker events --filter type=container
```

### Limpieza del Sistema

```bash
# Limpiar contenedores detenidos
docker container prune

# Limpiar imágenes sin usar
docker image prune

# Limpiar imágenes sin usar (incluyendo sin tag)
docker image prune -a

# Limpiar volúmenes sin usar
docker volume prune

# Limpiar redes sin usar
docker network prune

# Limpiar todo (contenedores, imágenes, redes)
docker system prune

# Limpiar todo incluyendo volúmenes
docker system prune -a --volumes

# Limpiar sin confirmación
docker system prune -f
```

---

## Registro y Logs

### Docker Hub

```bash
# Iniciar sesión en Docker Hub
docker login

# Iniciar sesión con credenciales
docker login -u usuario -p contraseña

# Cerrar sesión
docker logout

# Buscar imágenes
docker search término

# Subir imagen
docker push usuario/imagen:tag

# Descargar imagen
docker pull usuario/imagen:tag
```

### Logs y Debugging

```bash
# Ver logs del contenedor
docker logs mi-contenedor

# Logs en tiempo real
docker logs -f mi-contenedor

# Últimas N líneas
docker logs --tail 50 mi-contenedor

# Logs desde timestamp
docker logs --since 2024-01-01T00:00:00 mi-contenedor

# Logs hasta timestamp
docker logs --until 2024-01-01T23:59:59 mi-contenedor

# Logs con timestamps
docker logs -t mi-contenedor

# Ver estadísticas de recursos
docker stats

# Inspeccionar objeto (contenedor, imagen, red, volumen)
docker inspect objeto

# Ver procesos en contenedor
docker top mi-contenedor

# Ver cambios en sistema de archivos
docker diff mi-contenedor
```

---

## 🎯 Comandos Más Usados (Top 10)

```bash
# 1. Ver contenedores en ejecución
docker ps

# 2. Ejecutar contenedor
docker run -d -p 8080:80 --name mi-web nginx

# 3. Detener contenedor
docker stop mi-web

# 4. Ver logs
docker logs -f mi-web

# 5. Entrar al contenedor
docker exec -it mi-web bash

# 6. Construir imagen
docker build -t mi-imagen .

# 7. Listar imágenes
docker images

# 8. Eliminar contenedor
docker rm mi-web

# 9. Limpiar sistema
docker system prune -a

# 10. Ver estadísticas
docker stats
```

---

## 💡 Tips y Trucos

### Alias Útiles

```bash
# Agregar a ~/.bashrc o ~/.zshrc
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dex='docker exec -it'
alias dlog='docker logs -f'
alias dstop='docker stop $(docker ps -q)'
alias dclean='docker system prune -af'
```

### Formato de Salida Personalizado

```bash
# Contenedores con formato tabla
docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"

# Imágenes con tamaño
docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}"

# JSON para procesamiento
docker inspect --format='{{json .}}' mi-contenedor | jq
```

### Filtros Útiles

```bash
# Contenedores por estado
docker ps -a --filter status=exited

# Contenedores por nombre
docker ps --filter name=web

# Imágenes por etiqueta
docker images --filter label=version=1.0

# Eventos por tipo
docker events --filter type=container --filter event=start
```

---

**📚 Recursos**: [Documentación oficial de Docker](https://docs.docker.com/engine/reference/commandline/cli/)
