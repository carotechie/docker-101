# 🌐 Sitio Web de Ejemplo - Docker 101

Este es un sitio web educativo animado para aprender Docker de forma práctica.

## 🎯 Características

- 🐶 Cachorro animado feliz
- 🦆 Pato animado feliz
- 🐳 Logo de Docker giratorio
- 🎨 Diseño colorido y atractivo
- 📱 Responsive (se adapta a móviles)
- ✨ Animaciones CSS
- 🎉 Efectos interactivos

## 🚀 Inicio Rápido

### Opción 1: Usando el script de inicio rápido

```bash
# Desde el directorio docker-101
./inicio-rapido.sh
```

### Opción 2: Comandos manuales

```bash
# 1. Construir la imagen
docker build -t mi-sitio-web .

# 2. Ejecutar el contenedor
docker run -d -p 8080:80 --name mi-web mi-sitio-web

# 3. Abrir en el navegador
# http://localhost:8080
```

## 📁 Estructura del Proyecto

```
website/
├── Dockerfile          # Instrucciones para construir la imagen
├── index.html          # Sitio web con animaciones
└── README.md          # Este archivo
```

## 🐳 Dockerfile Explicado

```dockerfile
# Imagen base: Nginx Alpine (ligera, ~5MB)
FROM nginx:alpine

# Metadatos
LABEL maintainer="docker-101@ejemplo.com"
LABEL description="Sitio web educativo para aprender Docker"

# Copiar HTML al directorio de Nginx
COPY index.html /usr/share/nginx/html/index.html

# Exponer puerto 80
EXPOSE 80

# Comando para iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]
```

### ¿Por qué Nginx Alpine?

- **Ligera**: Solo ~5MB vs ~130MB de nginx:latest
- **Segura**: Menos superficie de ataque
- **Rápida**: Menos capas, construcción más rápida
- **Eficiente**: Ideal para contenedores

## 🎓 Ejercicios de Aprendizaje

### Ejercicio 1: Modificar el sitio

1. Edita `index.html` y cambia los colores
2. Reconstruye la imagen:
   ```bash
   docker build -t mi-sitio-web:v2 .
   ```
3. Detén el contenedor anterior:
   ```bash
   docker stop mi-web
   docker rm mi-web
   ```
4. Ejecuta el nuevo contenedor:
   ```bash
   docker run -d -p 8080:80 --name mi-web mi-sitio-web:v2
   ```
5. Abrir en el navegador
    http://localhost:8080

### Ejercicio 2: Usar diferentes puertos

```bash
# Puerto 3000
docker run -d -p 3000:80 --name mi-web-3000 mi-sitio-web

#Abrir en el navegador
    http://localhost:3000

# Puerto 9000
docker run -d -p 9000:80 --name mi-web-9000 mi-sitio-web

# Ahora tienes el mismo sitio en dos puertos diferentes
```
#Abrir en el navegador

http://localhost:9000



### Ejercicio 3: Desarrollo en vivo

Monta el archivo HTML como volumen para ver cambios sin reconstruir:

```bash
docker run -d -p 8080:80 \
  -v $(pwd)/index.html:/usr/share/nginx/html/index.html \
  --name mi-web-dev \
  nginx:alpine
```

Ahora puedes editar `index.html` y ver los cambios recargando el navegador.

### Ejercicio 4: Ver logs en tiempo real

```bash
# Ver logs
docker logs mi-web

# Ver logs en tiempo real
docker logs -f mi-web

# Abre el sitio en el navegador y verás las peticiones HTTP
```

### Ejercicio 5: Explorar el contenedor

```bash
# Entrar al contenedor
docker exec -it mi-web sh

# Una vez dentro, explora:
ls -la /usr/share/nginx/html/
cat /etc/nginx/nginx.conf
ps aux
exit
```

## 🔧 Comandos Útiles

```bash
# Ver el contenedor en ejecución
docker ps

# Ver todos los contenedores
docker ps -a

# Detener el contenedor
docker stop mi-web

# Iniciar el contenedor
docker start mi-web

# Reiniciar el contenedor
docker restart mi-web

# Ver logs
docker logs mi-web

# Ver estadísticas de recursos
docker stats mi-web

# Inspeccionar el contenedor
docker inspect mi-web

# Eliminar el contenedor
docker rm mi-web

# Eliminar la imagen
docker rmi mi-sitio-web
```

## 🎨 Personalización

### Cambiar el título

Busca en `index.html`:
```html
<h1>🐳 ¡Bienvenido a Docker 101!</h1>
```

### Cambiar los colores

Busca en la sección `<style>`:
```css
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
```

### Agregar más animales

Agrega en la sección `.animals-container`:
```html
<div class="animal" onclick="celebrate('🐱')" title="¡Gato feliz!">🐱</div>
```

## 🐛 Solución de Problemas

### El puerto 8080 ya está en uso

```bash
# Usar otro puerto
docker run -d -p 8081:80 --name mi-web mi-sitio-web

# O detener el proceso que usa el puerto 8080
# En Linux/Mac:
lsof -ti:8080 | xargs kill -9

# En Windows:
netstat -ano | findstr :8080
taskkill /PID <PID> /F
```

### El contenedor no inicia

```bash
# Ver logs de error
docker logs mi-web

# Verificar que la imagen se construyó correctamente
docker images | grep mi-sitio-web

# Reconstruir sin caché
docker build --no-cache -t mi-sitio-web .
```

### No puedo acceder al sitio

1. Verifica que el contenedor está corriendo:
   ```bash
   docker ps
   ```

2. Verifica el mapeo de puertos:
   ```bash
   docker port mi-web
   ```

3. Prueba con curl:
   ```bash
   curl http://localhost:8080
   ```

## 📚 Próximos Pasos

1. Lee el [README principal](../README.md) para más información
2. Explora [COMANDOS-DOCKER.md](../COMANDOS-DOCKER.md) para referencia rápida
3. Consulta las guías específicas de tu sistema operativo:
   - [Windows](../GUIA-WINDOWS.md)
   - [macOS](../GUIA-MAC.md)
   - [Linux](../GUIA-LINUX.md)

## 🤝 Contribuir

¿Tienes ideas para mejorar este sitio? ¡Las contribuciones son bienvenidas!

---

**¡Diviértete aprendiendo Docker! 🐳🐶🦆**
