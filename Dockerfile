FROM ubuntu:18.04

# Instalar dependencias para Ubuntu 18.04
RUN apt-get update && apt-get install -y \
    wget curl nginx supervisor ca-certificates \
    && apt-get clean

# Copiar las configuraciones que creamos arriba
COPY nginx.conf /etc/nginx/nginx.conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Crear el script de inicio (setup.sh) basado en tu link de git
RUN echo '#!/bin/bash\n\
apt-get update -y\n\
wget https://github.com/thefather12/ADM-FATHER2/raw/main/LACASITA.sh -O LACASITA.sh\n\
chmod 777 LACASITA.sh\n\
./LACASITA.sh --start\n\
tail -f /dev/null' > /setup.sh && chmod +x /setup.sh

EXPOSE 8080

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

