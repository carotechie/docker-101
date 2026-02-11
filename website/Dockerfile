# Usar Nginx Alpine como imagen base (ligera y eficiente)
FROM nginx:alpine

# Información del mantenedor
LABEL maintainer="docker-101@ejemplo.com"
LABEL description="Sitio web educativo para aprender Docker"

# Copiar el archivo HTML al directorio de Nginx
COPY index.html /usr/share/nginx/html/index.html

# Exponer el puerto 80
EXPOSE 80

# Comando para iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]
