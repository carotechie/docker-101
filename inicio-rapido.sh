#!/bin/bash

# Script de Inicio Rápido para Docker 101
# Este script te ayuda a construir y ejecutar el sitio web de ejemplo

set -e  # Salir si hay algún error

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # Sin color

# Función para imprimir mensajes
print_message() {
    echo -e "${BLUE}==>${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Banner
echo -e "${BLUE}"
cat << "EOF"
╔═══════════════════════════════════════╗
║                                       ║
║        🐳 Docker 101                  ║
║     Inicio Rápido                     ║
║                                       ║
╚═══════════════════════════════════════╝
EOF
echo -e "${NC}"

# Verificar si Docker está instalado
print_message "Verificando instalación de Docker..."
if ! command -v docker &> /dev/null; then
    print_error "Docker no está instalado"
    echo ""
    echo "Por favor, instala Docker siguiendo las guías:"
    echo "  - Windows: GUIA-WINDOWS.md"
    echo "  - macOS: GUIA-MAC.md"
    echo "  - Linux: GUIA-LINUX.md"
    exit 1
fi
print_success "Docker está instalado"

# Verificar si Docker está corriendo
print_message "Verificando que Docker esté corriendo..."
if ! docker info &> /dev/null; then
    print_error "Docker no está corriendo"
    echo ""
    echo "Por favor, inicia Docker Desktop o el servicio de Docker"
    exit 1
fi
print_success "Docker está corriendo"

# Mostrar versión de Docker
DOCKER_VERSION=$(docker --version)
print_success "Versión: $DOCKER_VERSION"

echo ""
print_message "¿Qué deseas hacer?"
echo ""
echo "  1) Construir y ejecutar el sitio web"
echo "  2) Solo construir la imagen"
echo "  3) Solo ejecutar el contenedor (si ya está construido)"
echo "  4) Detener y eliminar el contenedor"
echo "  5) Ver contenedores en ejecución"
echo "  6) Ver logs del contenedor"
echo "  7) Entrar al contenedor"
echo "  8) Limpiar todo (contenedores e imágenes)"
echo "  9) Salir"
echo ""
read -p "Selecciona una opción (1-9): " option

case $option in
    1)
        print_message "Construyendo y ejecutando el sitio web..."
        
        # Navegar al directorio website
        if [ ! -d "website" ]; then
            print_error "El directorio 'website' no existe"
            exit 1
        fi
        
        cd website
        
        # Detener y eliminar contenedor existente si existe
        if docker ps -a --format '{{.Names}}' | grep -q '^mi-web$'; then
            print_warning "Deteniendo contenedor existente..."
            docker stop mi-web &> /dev/null || true
            docker rm mi-web &> /dev/null || true
        fi
        
        # Construir imagen
        print_message "Construyendo imagen Docker..."
        docker build -t mi-sitio-web .
        print_success "Imagen construida exitosamente"
        
        # Ejecutar contenedor
        print_message "Ejecutando contenedor..."
        docker run -d -p 8080:80 --name mi-web mi-sitio-web
        print_success "Contenedor ejecutándose"
        
        echo ""
        print_success "¡Listo! 🎉"
        echo ""
        echo "Tu sitio web está disponible en:"
        echo -e "${GREEN}  http://localhost:8080${NC}"
        echo ""
        echo "Comandos útiles:"
        echo "  Ver logs:        docker logs -f mi-web"
        echo "  Detener:         docker stop mi-web"
        echo "  Entrar:          docker exec -it mi-web sh"
        echo ""
        
        # Intentar abrir en el navegador
        if command -v xdg-open &> /dev/null; then
            xdg-open http://localhost:8080 &> /dev/null &
        elif command -v open &> /dev/null; then
            open http://localhost:8080 &> /dev/null &
        elif command -v start &> /dev/null; then
            start http://localhost:8080 &> /dev/null &
        fi
        ;;
        
    2)
        print_message "Construyendo imagen..."
        
        if [ ! -d "website" ]; then
            print_error "El directorio 'website' no existe"
            exit 1
        fi
        
        cd website
        docker build -t mi-sitio-web .
        print_success "Imagen construida exitosamente"
        
        echo ""
        echo "Para ejecutar el contenedor, usa:"
        echo "  docker run -d -p 8080:80 --name mi-web mi-sitio-web"
        ;;
        
    3)
        print_message "Ejecutando contenedor..."
        
        # Verificar si la imagen existe
        if ! docker images --format '{{.Repository}}' | grep -q '^mi-sitio-web$'; then
            print_error "La imagen 'mi-sitio-web' no existe"
            echo "Primero construye la imagen con la opción 2"
            exit 1
        fi
        
        # Detener y eliminar contenedor existente si existe
        if docker ps -a --format '{{.Names}}' | grep -q '^mi-web$'; then
            print_warning "Deteniendo contenedor existente..."
            docker stop mi-web &> /dev/null || true
            docker rm mi-web &> /dev/null || true
        fi
        
        docker run -d -p 8080:80 --name mi-web mi-sitio-web
        print_success "Contenedor ejecutándose en http://localhost:8080"
        ;;
        
    4)
        print_message "Deteniendo y eliminando contenedor..."
        
        if docker ps -a --format '{{.Names}}' | grep -q '^mi-web$'; then
            docker stop mi-web &> /dev/null || true
            docker rm mi-web &> /dev/null || true
            print_success "Contenedor eliminado"
        else
            print_warning "No hay contenedor 'mi-web' para eliminar"
        fi
        ;;
        
    5)
        print_message "Contenedores en ejecución:"
        echo ""
        docker ps
        ;;
        
    6)
        print_message "Mostrando logs del contenedor..."
        echo ""
        if docker ps --format '{{.Names}}' | grep -q '^mi-web$'; then
            docker logs -f mi-web
        else
            print_error "El contenedor 'mi-web' no está en ejecución"
        fi
        ;;
        
    7)
        print_message "Entrando al contenedor..."
        echo ""
        if docker ps --format '{{.Names}}' | grep -q '^mi-web$'; then
            print_success "Conectado al contenedor. Escribe 'exit' para salir."
            docker exec -it mi-web sh
        else
            print_error "El contenedor 'mi-web' no está en ejecución"
        fi
        ;;
        
    8)
        print_warning "Esto eliminará el contenedor y la imagen"
        read -p "¿Estás seguro? (s/n): " confirm
        
        if [ "$confirm" = "s" ] || [ "$confirm" = "S" ]; then
            print_message "Limpiando..."
            
            # Detener y eliminar contenedor
            if docker ps -a --format '{{.Names}}' | grep -q '^mi-web$'; then
                docker stop mi-web &> /dev/null || true
                docker rm mi-web &> /dev/null || true
                print_success "Contenedor eliminado"
            fi
            
            # Eliminar imagen
            if docker images --format '{{.Repository}}' | grep -q '^mi-sitio-web$'; then
                docker rmi mi-sitio-web &> /dev/null || true
                print_success "Imagen eliminada"
            fi
            
            print_success "Limpieza completada"
        else
            print_message "Operación cancelada"
        fi
        ;;
        
    9)
        print_message "¡Hasta luego! 👋"
        exit 0
        ;;
        
    *)
        print_error "Opción inválida"
        exit 1
        ;;
esac

echo ""
print_message "¡Feliz aprendizaje con Docker! 🐳"
