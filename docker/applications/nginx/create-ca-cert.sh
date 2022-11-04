#!/bin/bash
source ../../../lib.sh
source init.sh

#log "Creating CA certificate. Please specify cert name..."
#read -p "CA name> " cert_name
## You will be prompted to set a passphrase. Make sure to set it to something you’ll remember.
#openssl req -new -newkey rsa:1024 -nodes -keyout ca.key -x509 -days 500 -subj /C=RU/ST=Moscow/L=Moscow/O=Companyname/OU=User/CN=etc/emailAddress=support@site.com -out ca.crt
if openssl req -new -newkey rsa:1024 -nodes -keyout $ca_cert_key -x509 -days 500 \
	-subj /C=RU/ST=Moscow/L=Moscow/O=Companyname/OU=User/CN=etc/emailAddress=support@site.com \
	-out $ca_cert_crt; then 
	log "Files $ca_cert_key, $ca_cert_crt were created";
else
	log_error "Couldn't create files $ca_cert_key, $ca_cert_crt"
fi
#if openssl genrsa -des3 -out $cert_name.key 4096; then 
#	log "File $cert_name.key created";
#else
#	log_error "Couldn't create file $cert_name.key"
#fi

## Makes the signing CA valid for 10 years. Change as requirements dictate.
## You will be asked to fill in attributes for your CA.
#log "Creating file $cert_name.crt..."
#if openssl req -new -x509 -days 3650 -key $cert_name.key -out $cert_name.crt; then
#	log "Created file $cert_name.crt"
#else
#	log_error "Couldn't create file $cert_name.crt"
#fi

