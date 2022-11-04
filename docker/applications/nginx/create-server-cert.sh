#!/bin/bash
source ../../../lib.sh
source init.sh

#log "Creating server certificate. Please specify cert name in format /path/to/cert_name WITHOUT extension"
#read -p "Certificate name without extension> " cert_name
#read -p "Path to store server's certificate> " directory
#read -p "CA certificate name> " cert_ca_file
## You will be prompted to set a passphrase. Make sure to set it to something you’ll remember.
#openssl req -new -newkey rsa:1024 -nodes -keyout ca.key -x509 -days 500 -subj /C=RU/ST=Moscow/L=Moscow/O=Companyname/OU=User/CN=etc/emailAddress=support@site.com -out ca.crt


if log "Creating server's certificate $server_cert_key" &&\
	openssl genrsa -des3 -out $server_cert_key 1024 &&\
	log "Creating csr file $server_cert_csr" &&\
   	openssl req -new -key $server_cert_key -subj $server_cert_subject -out $server_cert_csr; 
then 
	log "Files $server_cert_key, $server_cert_csr were created";
else
	log_error "Couldn't create files $server_cert_key, $server_cert_csr"
	exit 0
fi
echo openssl x509 -req -days 365 -in $server_cert_csr -CA $ca_cert_crt -CAkey $ca_cert_key -set_serial 01 -out $server_cert_crt
log "(Self) Signing the $server_cert_csr certificate by $ca_cert_crt..."
if pwd && openssl x509 -req -days 365 -in $server_cert_csr -CA $ca_cert_crt -CAkey $ca_cert_key -set_serial 02 -out $server_cert_crt; 
then
	log "File $server_cert_csr was signed to file: $server_cert_crt";
else
	log_error "Couldn't sign the file $server_cert_csr"
	exit 0
fi

log "Creating nopass version of $server_cert_crt..."

if openssl rsa -in $server_cert_key -out $server_cert_key.nopass; then
	log "Nopass cert is: $server_cert_key.nopass"
else
	log_error "Couldn't create nopass file for $server_cert_key file"
	exit 0
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

