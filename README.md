
# Arroyo consulting Test

#### Brief:

Make a Docker image using Linux virtual machine with the following specifications:

- Install Git
- Install Vs Code
- Install Maven
- Install PostgreSQL
- Install Java JRE
- It has to be able to compile NetCore projects
- It has to be able to compile Java applications
- Upload and host a hello world project using apache


## Deployment

To deploy this project you can do it downloading the image and running it or instead you can build it locally

###  Building it locally:

First you would have to clone this repository on your local machine using:

```bash
git clone https://github.com/pedroslev/arroyoConsulting-test.git
cd arroyoConsulting-test/
sudo chmod 777 build.sh
sudo chmod 777 run.sh
```

Make sure you have docker installed. I have provided bash scripts to build and run this container, you can check the content, they are called `build.sh` and `run.sh` and they just contain docker commands for building and running the container

Finally you would have to run:
```bash
sudo ./build.sh && ./run.sh
```
After this you can open `localhost:80` on your browser and you would be able to see the helloWorld project

### Downloading image and running it

#### Using Linux:
``` bash
docker run -d -p 80:80 pedroslev/arroyoconsulting-test:linux
```

note: you can also try this in https://labs.play-with-docker.com/ if you don't have docker installed

#### Using Macbook m1

``` bash
docker run -d -p 80:80 pedroslev/arroyoconsulting-test:m1
```
## Documentation

This is the Dockerfile used for the image making, starting off from an ubuntu software, configuring tzdata to avoid interaction and installing requisites.

I have commented out the java compiling section because I don't provide a .jar to test it, you can place your own .jar inside `javaApp` folder


As an extra point I have added commented lines for running this container using port 443 and a self made ssl using openssl tool.
```DOCKERFILE
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

```
