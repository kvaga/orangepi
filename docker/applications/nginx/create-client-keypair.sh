#!/bin/sh
source ../../../../lib.sh
log "Creating client's keypair. Please specify client name: " 
read -p "Client name> " client_name
echo 
log "Please specife CA name file WITHOUT extendsion"
ls -la 
read -p "CA> " ca_name
log "The [$client_name.crt, $client_name.key and $client_name.pfx] files will be saved to ."


## You will be prompted for a passphrase which will be distributed to your user with the certificate. Do NOT ever distribute the passphrase set above for your root CA’s private key. Make sure you understand this distinction!
log "Creating $client_name.key..."
if openssl genrsa -des3 -out $client_name.key 2048; then
	log "File [$client_name.key] created"
else
	log_error "Couldn't create file $client_name.key"
fi

log "Creating file $client_name.csr..."
if openssl req -new -key $client_name.key -out $client_name.csr; then
	log "File $client_name.csr created"
else
	log_error "Couldn't create file $client_name.csr"
fi

## Sign with our certificate-signing CA
## This certificate will be valid for one year. Change as per your requirements.
## You can increment the serial if you have to reissue the CERT
log "Creating file $client_name.crt..."
if openssl x509 -req -days 365 -in $client_name.csr -CA $ca_name.crt -CAkey $ca_name.key -set_serial 01 -out $client_name.crt; then
	log "File $client_name.crt created"
else
	log_error "Couldn't create file $client_name.crt"
fi

## For Windows clients, the key material can be combined into a single PFX. You will be prompted for the passphrase you set above.
log "Creating file $client_name.pfx..."
if openssl pkcs12 -export -out $client_name.pfx -inkey $client_name.key -in $client_name.crt -certfile $ca_name.crt; then
	log "File $client_name.pfx created"
else
	log_error "Couldn't create file $client_name.pfx"
fi

log "Files $client_name.crt, $client_name.key and $client_name.pfx were be saved to ."

