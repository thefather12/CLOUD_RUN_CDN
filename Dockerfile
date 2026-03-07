FROM alpine

COPY server /server
RUN chmod +x /server

server ["/server"]