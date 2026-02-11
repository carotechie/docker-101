# 🍎 Guía de Docker para macOS

## Requisitos del Sistema

- macOS 11 (Big Sur) o superior
- Procesador Apple Silicon (M1/M2/M3) o Intel
- Mínimo 4GB de RAM (recomendado 8GB)

## Instalación Paso a Paso

### Opción 1: Instalación con Homebrew (Recomendado)

```bash
# Instalar Homebrew si no lo tienes
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Instalar Docker Desktop
brew install --cask docker

# Abrir Docker Desktop
open /Applications/Docker.app
```

### Opción 2: Instalación Manual

1. **Descargar Docker Desktop:**
   - Visita: https://www.docker.com/products/docker-desktop
   - Descarga la versión correcta:
     - "Docker Desktop for Mac with Apple Silicon" (M1/M2/M3)
     - "Docker Desktop for Mac with Intel chip" (Intel)

2. **Instalar:**
   - Abre el archivo `.dmg` descargado
   - Arrastra el ícono de Docker a la carpeta "Aplicaciones"
   - Abre Docker desde Aplicaciones
   - Autoriza los permisos cuando macOS lo solicite

3. **Primera configuración:**
   - Acepta los términos de servicio
   - Opcionalmente, inicia sesión con tu Docker ID
   - Espera a que Docker inicie completamente

### Verificar la Instalación

Abre Terminal y ejecuta:

```bash
# Verificar versión de Docker
docker --version

# Verificar versión de Docker Compose
docker compose version

# Probar Docker
docker run hello-world
```

Si ves "Hello from Docker!", ¡todo está funcionando! 🎉

## Configuración Recomendada

### Acceder a Configuración

Haz clic en el ícono de Docker en la barra de menú → Preferences

### Configuraciones Importantes

**General:**
- ✅ Start Docker Desktop when you log in
- ✅ Use Docker Compose V2

**Resources:**
- CPUs: 2-4 (dependiendo de tu Mac)
- Memory: 4-8 GB
- Swap: 1-2 GB
- Disk image size: 60 GB (ajustable)

**Docker Engine:**
```json
{
  "builder": {
    "gc": {
      "defaultKeepStorage": "20GB",
      "enabled": true
    }
  },
  "experimental": false
}
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
open http://localhost:8080
```

## Comandos Útiles en macOS

```bash
# Ver contenedores en ejecución
docker ps

# Ver todos los contenedores
docker ps -a

# Detener contenedor
docker stop mi-web

# Iniciar contenedor detenido
docker start mi-web

# Reiniciar contenedor
docker restart mi-web

# Eliminar contenedor
docker rm mi-web

# Ver logs en tiempo real
docker logs -f mi-web

# Entrar al contenedor
docker exec -it mi-web sh

# Ver estadísticas de recursos
docker stats

# Limpiar recursos no utilizados
docker system prune -a

# Ver espacio usado por Docker
docker system df
```

## Atajos y Trucos para Mac

### Alias útiles para Terminal

Agrega estos alias a tu `~/.zshrc` o `~/.bash_profile`:

```bash
# Alias de Docker
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dex='docker exec -it'
alias dlog='docker logs -f'
alias dstop='docker stop $(docker ps -q)'
alias dclean='docker system prune -af'

# Recargar configuración
source ~/.zshrc  # o source ~/.bash_profile
```

### Funciones útiles

```bash
# Función para entrar rápidamente a un contenedor
dsh() {
    docker exec -it $1 sh
}

# Función para construir y ejecutar
dbr() {
    docker build -t $1 . && docker run -d -p $2:80 --name $1 $1
}

# Uso:
# dsh mi-web
# dbr mi-sitio-web 8080
```

## Integración con Herramientas de Desarrollo

### Visual Studio Code

```bash
# Instalar extensión de Docker
code --install-extension ms-azuretools.vscode-docker
```

### iTerm2 (Terminal mejorada)

```bash
# Instalar iTerm2
brew install --cask iterm2
```

### Docker CLI Completion

```bash
# Para Zsh (shell por defecto en macOS)
echo 'autoload -Uz compinit && compinit' >> ~/.zshrc
source ~/.zshrc
```

## Solución de Problemas Comunes

### Docker Desktop no inicia

```bash
# Reiniciar Docker desde Terminal
killall Docker && open /Applications/Docker.app

# O usar el menú
# Clic en ícono de Docker → Troubleshoot → Restart Docker Desktop
```

### Error: "Cannot connect to the Docker daemon"

```bash
# Verificar que Docker Desktop está corriendo
ps aux | grep Docker

# Si no está corriendo, abrirlo
open /Applications/Docker.app
```

### Problemas de rendimiento en Apple Silicon

Si tienes un Mac M1/M2/M3 y experimentas lentitud:

1. Asegúrate de usar la versión para Apple Silicon
2. En Preferences → General, desmarca "Use Rosetta for x86/amd64 emulation"
3. Usa imágenes nativas ARM64 cuando sea posible:
   ```bash
   docker pull --platform linux/arm64 nginx:alpine
   ```

### Liberar espacio en disco

```bash
# Ver cuánto espacio usa Docker
docker system df

# Limpiar todo lo no utilizado
docker system prune -a --volumes

# Limpiar solo imágenes
docker image prune -a

# Limpiar solo contenedores
docker container prune

# Limpiar solo volúmenes
docker volume prune
```

### Error de permisos

```bash
# Agregar tu usuario al grupo docker (si es necesario)
sudo dscl . -append /Groups/docker GroupMembership $USER

# Cerrar sesión y volver a iniciar
```

## Optimización para Mac

### Usar volúmenes delegados para mejor rendimiento

```bash
# En lugar de:
docker run -v $(pwd):/app myimage

# Usa:
docker run -v $(pwd):/app:delegated myimage
```

### Limitar recursos para evitar sobrecalentamiento

En Docker Desktop → Preferences → Resources:
- Reduce CPUs a 2
- Reduce Memory a 4GB
- Esto ayuda a mantener tu Mac más fresco

## Monitoreo de Recursos

```bash
# Ver uso de CPU y memoria de contenedores
docker stats

# Ver procesos dentro de un contenedor
docker top mi-web

# Inspeccionar configuración del contenedor
docker inspect mi-web
```

## Comandos Avanzados

```bash
# Exportar contenedor como imagen
docker commit mi-web mi-web-backup

# Guardar imagen en archivo
docker save -o mi-imagen.tar mi-sitio-web

# Cargar imagen desde archivo
docker load -i mi-imagen.tar

# Copiar archivos desde/hacia contenedor
docker cp mi-web:/ruta/archivo.txt ./
docker cp ./archivo.txt mi-web:/ruta/

# Crear red personalizada
docker network create mi-red

# Ejecutar contenedor en red específica
docker run -d --network mi-red --name mi-web mi-sitio-web
```

## Recursos Adicionales

- [Documentación de Docker Desktop para Mac](https://docs.docker.com/desktop/mac/)
- [Docker para Apple Silicon](https://docs.docker.com/desktop/mac/apple-silicon/)
- [Mejores prácticas de Docker](https://docs.docker.com/develop/dev-best-practices/)

## Desinstalación (si es necesario)

```bash
# Usando Homebrew
brew uninstall --cask docker

# Manual
# 1. Cerrar Docker Desktop
# 2. Arrastrar Docker.app a la Papelera
# 3. Limpiar archivos residuales:
rm -rf ~/Library/Group\ Containers/group.com.docker
rm -rf ~/Library/Containers/com.docker.docker
rm -rf ~/.docker
```

---

**💡 Consejo**: Usa `⌘ + Espacio` y escribe "Docker" para abrir rápidamente Docker Desktop desde Spotlight.
