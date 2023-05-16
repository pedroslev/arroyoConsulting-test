FROM ubuntu:latest

##bc of interactive problems installing tzdata.
ENV TZ America/Argentina/Buenos_Aires
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y\
    git \
#There is no such visual studio code for headless containers
#   code \
    maven \
    postgresql-client \
    postgresql \
    openjdk-11-jre \
    openssl \
    apache2

WORKDIR /app

#Uncomment if needed to compile a jar
#COPY javaApp/*.jar my-app.jar

#RUN mvn clean install
#RUN java -jar my-app.jar

#If needing to secure using a self-made cert -> uncomment
#COPY ./default.conf /etc/apache2/sites-available/default
#COPY certs/server.key /etc/ssl/private/server.key
#COPY certs/server.pem /etc/ssl/certs/server.pem

WORKDIR /var/www/html

##Enabling the proxy and proxy_http modules for apache HTTP Server (good practice)
RUN a2enmod proxy
RUN a2enmod proxy_http

##Coping the helloworld page example
COPY ./helloWorld/* .

#Uncomment and comment depending on secured or unsecured
EXPOSE 80
#EXPOSE 443

#Running apache as a service with apache2ctl command
CMD ["apache2ctl", "-D", "FOREGROUND"]

