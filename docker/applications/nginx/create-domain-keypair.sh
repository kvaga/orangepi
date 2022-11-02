#!/bin/sh
source ../../../lib.sh

certificates_path=CertificateAuthCA
log "Creating domain key pair in the directory [$certificates_path]..."
read -p "Domain key name> " domain

## Generate an RSA Private Key (You will be prompted to set a passphrase and fill out attributes)
if openssl genrsa -out $certificates_path/$domain.key 2048; then
	log "Created file [$certificates_path/$domain.key]"
else
	log_error "Couldn't create file [$certificates_path/$domain.key]"
fi

## Use it to create a CSR to send us
log "Creating file [$certificates_path/$domain.csr]..."
if openssl req -new -sha256 -key $certificates_path/domain.com.key -out $certificates_path/domain.com.csr; then
	log "Created file [$certificates_path/$domain.csr]"
else
	log_error "Couldn't create file [$certificates_path/$domain.csr]"
fi
