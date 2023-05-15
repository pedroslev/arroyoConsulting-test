FROM alpine:latest

RUN apk add --no-cache \
    git \
#    code-server-bin \
    maven \
    postgresql-client \
    openjdk11 \
#    openssl \
    apache2

WORKDIR /app

#COPY ./default.conf /etc/apache2/sites-available/default

#COPY certs/server.key /etc/ssl/private/server.key
#COPY certs/server.pem /etc/ssl/certs/server.pem

# Remove Subject Alt Name line

#RUN sed -i '/Subject Alt Name=/d' /etc/apache2/sites-available/default

WORKDIR /var/www/html

COPY ./helloWorld/* .

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

EXPOSE 443
