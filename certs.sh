#!/bin/bash

# Create a directory for the certificates
mkdir -p certs

# Create a key and a certificate request
openssl req -new -newkey rsa:2048 -nodes -keyout certs/server.key -out certs/server.csr

# Remove Subject Alt Name line
sed -i '/Subject Alt Name=/d' certs/server.csr

# Sign the certificate request
openssl x509 -in certs/server.csr -out certs/server.pem -req -signkey certs/server.key -days 365

# Print the certificate information
openssl x509 -in certs/server.pem -text -noout