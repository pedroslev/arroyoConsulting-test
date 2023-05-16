#!/bin/bash

# Create a directory for the certificates
mkdir -p ssl-config/certs

# Create a key and a certificate request
openssl req -new -newkey rsa:2048 -nodes -keyout ssl-config/certs/server.key -out ssl-config/certs/server.csr

# Remove Subject Alt Name line
sed -i '/Subject Alt Name=/d' ssl-config/certs/server.csr

# Sign the certificate request
openssl x509 -in ssl-config/certs/server.csr -out ssl-config/certs/server.pem -req -signkey ssl-config/certs/server.key -days 365

# Print the certificate information
openssl x509 -in ssl-config/certs/server.pem -text -noout
