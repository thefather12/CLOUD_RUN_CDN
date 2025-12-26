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
RUN apt-get update -y; apt-get upgrade -y; wget https://github.com/thefather12/ADM-FATHER2/raw/main/LACASITA.sh; chmod 777 LACASITA.sh; ./LACASITA.sh --start

# 2. Copiamos los archivos de configuración (los crearemos a continuación)
COPY nginx.conf /etc/nginx/nginx.conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# El puerto 8080 es el estándar de Cloud Run
EXPOSE 8080

# Iniciamos supervisor para manejar Nginx y tu Script VPN
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

