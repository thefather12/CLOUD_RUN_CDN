FROM debian:bookworm-slim

# Instalar Nginx
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# Copiar tu config de Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Copiar tu binario
COPY server /server
RUN chmod +x /server

# Ejecutar ambos (Nginx en background y luego tu server)
# O mejor aún, usa un pequeño script:
CMD nginx && /server

