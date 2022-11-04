#!/bin/bash
source ../../../lib.sh
source init.sh

log "Creating client's keypair. Please specify client name WITHOUT extension: " 
read -p "Client name> " client_name
client_cert_key=$client_cert_path/$client_name.key
client_cert_csr=$client_cert_path/$client_name.csr
client_cert_crt=$client_cert_path/$client_name.crt
client_cert_p12=$client_cert_path/$client_name.p12

log "Clear old certificates if exist"
rm $client_cert_key
rm $client_cert_csr
rm $client_cert_crt
rm $client_cert_p12

log "Check if doesn't exist file $index_file"
if [ ! -f "$index_file" ];
then 
	log_warn "File $index_file doesn't exist"
	touch $index_file && echo "01" > $serial_file
	log "Files $index_file, $serial_file created"
else
	log "File $index_file exists"
fi

#echo 
#log "Please specife CA name file WITHOUT extendsion"
#ls -la 
#read -p "CA> " ca_name
log "The [$client_cert_csr, $client_cert_key and $client_cert_crt] files will be saved to $directory"

log "Read serial number from the file $serial_file"
num_serial=$(cat $serial_file)
log "Current serial number: "$num_serial
num_serial=`expr $num_serial + 1`
num_serail="0$num_serial"
log "Next serial num: "$num_serial
## You will be prompted for a passphrase which will be distributed to your user with the certificate. Do NOT ever distribute the passphrase set above for your root CA’s private key. Make sure you understand this distinction!
log "Creating $client_cert_key and $client_cert_csr..."
#if openssl genrsa -des3 -out $client_name.key 2048; then
if openssl req -new -newkey $key_type -nodes -keyout $client_cert_key -set_serial "0x`openssl rand -hex 8`" \
	-subj /C=RU/ST=Moscow/L=Moscow/O=Companyname/OU=User/CN=$client_name/emailAddress=support@site.com \
	-out $client_cert_csr; then
	#echo "0$num_serial" > $serial_file
	log "Files [$client_cert_key, $client_cert_csr] were created. Newly created erial num $num_serial saved to $serial_file file"
else
	log_error "Couldn't create files $client_cert_key, $client_cert_csr"
	exit 0
fi

log "Signing file $client_cert_csr..."
if openssl ca -config ca.config -in $client_cert_csr -out $client_cert_crt -batch;
then log "File $client_cert_csr signed. Result file is: $client_cert_crt";
else 
	log_error "Couldn't sign the file $client_cert_csr"
	exit 0
fi

log "Creating certificate for browsers..."
if openssl pkcs12 -export -in $client_cert_crt -inkey $client_cert_key -certfile $ca_cert_crt -out $client_cert_p12;
then log "Created file $client_cert_p12";
else 
	log_error "Couldn't create file $client_cert_p12";
	exit 0
fi
#log "Creating file $client_name.csr..."
#if openssl req -new -key $client_name.key -out $client_name.csr; then
#	log "File $client_name.csr created"
#else
#	log_error "Couldn't create file $client_name.csr"
#fi

## Sign with our certificate-signing CA
## This certificate will be valid for one year. Change as per your requirements.
## You can increment the serial if you have to reissue the CERT
#log "Creating file client_cert_csr..."
#if openssl x509 -req -days 365 -in $client_name.csr -CA $ca_name.crt -CAkey $ca_name.key -set_serial 01 -out client_cert_csr; then
#	log "File client_cert_csr created"
#else
#	log_error "Couldn't create file client_cert_csr"
#fi

## For Windows clients, the key material can be combined into a single PFX. You will be prompted for the passphrase you set above.
#log "Creating file $client_name.pfx..."
#if openssl pkcs12 -export -out $client_name.pfx -inkey $client_name.key -in client_cert_csr -certfile $ca_name.crt; then
#	log "File $client_name.pfx created"
#else
#	log_error "Couldn't create file $client_name.pfx"
#fi

#log "Files client_cert_csr, $client_name.key and $client_name.pfx were be saved to ."

#log "Removing password phrase from $client_name.key file..."

#if openssl rsa -in $client_name.key -out $client_name.key.nopass; then
#	log "Password phrase removed from $client_name.key file"
#else
#	log_error "Couldn't remove password phrase from the $client_name.key file"
#fi"
