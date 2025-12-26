FROM ubuntu:18.04

# Evitar preguntas interactivas durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Actualizamos e instalamos herramientas básicas
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    nginx \
    supervisor \
    ca-certificates \
    && apt-get clean

# 1. Bajamos tu script desde tu repo de GitHub
# Reemplaza el link por tu link real de wget
RUN wget https://raw.githubusercontent.com/tu-usuario/tu-repo/main/setup.sh -O /setup.sh \
    && chmod +x /setup.sh

# 2. Copiamos los archivos de configuración (los crearemos a continuación)
COPY nginx.conf /etc/nginx/nginx.conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# El puerto 8080 es el estándar de Cloud Run
EXPOSE 8080

# Iniciamos supervisor para manejar Nginx y tu Script VPN
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

