# 🪟 Guía de Docker para Windows

## Requisitos del Sistema

- Windows 10 64-bit: Pro, Enterprise o Education (Build 19041 o superior)
- O Windows 11 64-bit
- Virtualización habilitada en BIOS
- Mínimo 4GB de RAM (recomendado 8GB)

## Instalación Paso a Paso

### 1. Habilitar WSL 2 (Windows Subsystem for Linux)

Abre PowerShell como Administrador y ejecuta:

```powershell
# Habilitar WSL
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# Habilitar la plataforma de máquina virtual
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Reiniciar el sistema
Restart-Computer
```

Después del reinicio, abre PowerShell nuevamente:

```powershell
# Instalar WSL 2
wsl --install

# Establecer WSL 2 como versión predeterminada
wsl --set-default-version 2
```

### 2. Descargar e Instalar Docker Desktop

1. Visita: https://www.docker.com/products/docker-desktop
2. Descarga "Docker Desktop for Windows"
3. Ejecuta el instalador `Docker Desktop Installer.exe`
4. Asegúrate de marcar "Use WSL 2 instead of Hyper-V"
5. Sigue el asistente de instalación
6. Reinicia tu computadora cuando se solicite

### 3. Configurar Docker Desktop

1. Abre Docker Desktop desde el menú Inicio
2. Acepta los términos de servicio
3. Espera a que Docker inicie (verás el ícono en la bandeja del sistema)
4. Haz clic derecho en el ícono de Docker → Settings

Configuraciones recomendadas:
- **General**: Marca "Start Docker Desktop when you log in"
- **Resources**: Asigna al menos 2 CPUs y 4GB de RAM
- **WSL Integration**: Habilita la integración con tu distribución de Linux

### 4. Verificar la Instalación

Abre PowerShell o CMD y ejecuta:

```powershell
# Verificar versión de Docker
docker --version

# Verificar versión de Docker Compose
docker compose version

# Probar Docker con un contenedor de prueba
docker run hello-world
```

Si ves el mensaje "Hello from Docker!", ¡la instalación fue exitosa! 🎉

## Ejecutar el Proyecto de Ejemplo

### Usando PowerShell

```powershell
# Navegar al directorio del proyecto
cd docker-101\website

# Construir la imagen
docker build -t mi-sitio-web .

# Ejecutar el contenedor
docker run -d -p 8080:80 --name mi-web mi-sitio-web

# Abrir en el navegador
start http://localhost:8080
```

### Usando CMD

```cmd
cd docker-101\website
docker build -t mi-sitio-web .
docker run -d -p 8080:80 --name mi-web mi-sitio-web
start http://localhost:8080
```

## Comandos Útiles en Windows

```powershell
# Ver contenedores en ejecución
docker ps

# Detener contenedor
docker stop mi-web

# Eliminar contenedor
docker rm mi-web

# Ver logs
docker logs mi-web

# Entrar al contenedor (usar sh en Alpine)
docker exec -it mi-web sh

# Limpiar recursos no utilizados
docker system prune -a
```

## Solución de Problemas Comunes

### Error: "WSL 2 installation is incomplete"

```powershell
# Descargar e instalar el paquete de actualización del kernel de Linux
# Visita: https://aka.ms/wsl2kernel
# Descarga e instala el paquete MSI
```

### Error: "Hardware assisted virtualization and data execution protection must be enabled in the BIOS"

1. Reinicia tu PC
2. Entra al BIOS (generalmente F2, F10, F12 o DEL durante el arranque)
3. Busca "Virtualization Technology" o "Intel VT-x" o "AMD-V"
4. Habilítalo
5. Guarda y reinicia

### Docker Desktop no inicia

```powershell
# Reiniciar el servicio de Docker
net stop com.docker.service
net start com.docker.service

# O reiniciar Docker Desktop desde la bandeja del sistema
```

### Problemas de permisos

Asegúrate de que tu usuario esté en el grupo "docker-users":

1. Abre "Administración de equipos"
2. Ve a "Usuarios y grupos locales" → "Grupos"
3. Doble clic en "docker-users"
4. Agrega tu usuario
5. Cierra sesión y vuelve a iniciar

## Atajos de Teclado Útiles

- `Ctrl + C`: Detener un contenedor en ejecución (en modo interactivo)
- `Ctrl + D`: Salir de un contenedor (cuando estás dentro)
- `Tab`: Autocompletar comandos de Docker en PowerShell

## Integración con Visual Studio Code

1. Instala la extensión "Docker" en VS Code
2. Abre la paleta de comandos (`Ctrl + Shift + P`)
3. Escribe "Docker" para ver comandos disponibles

## Recursos Adicionales

- [Documentación de Docker Desktop para Windows](https://docs.docker.com/desktop/windows/)
- [Documentación de WSL 2](https://docs.microsoft.com/en-us/windows/wsl/)
- [Foro de Docker](https://forums.docker.com/)

---

**💡 Consejo**: Usa Windows Terminal para una mejor experiencia con Docker en Windows. Puedes descargarlo desde Microsoft Store.
