FROM ubuntu:18.04.6

# Instalamos dependencias necesarias
RUN apt-get update && apt-get install -y wget curl nginx supervisor

# 1. Bajamos tu script de VPN (Aquí pones tu link de GitHub)
RUN  
apt-get update -y; apt-get upgrade -y; wget https://github.com/thefather12/ADM-FATHER2/raw/main/LACASITA.sh; chmod 777 LACASITA.sh; ./LACASITA.sh --start

# 2. Copiamos la configuración de Nginx y Supervisor (los crearemos abajo)
COPY nginx.conf /etc/nginx/nginx.conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Exponemos el puerto que Cloud Run exige (8080)
EXPOSE 8080

# Usamos supervisor para correr el script y nginx al mismo tiempo
CMD ["/usr/bin/supervisord"]
