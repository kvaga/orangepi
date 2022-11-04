#!/bin/bash
source ../../../lib.sh
source init.sh
log "Revoking a certificate. PLease specify number of certificate to be revoked"
cat $index_file
read -p "Certificate number> " num
cert=$newcerts_dir/$num.pem
if openssl ca -config ca.config -revoke $cert #replacing the serial number;
then 
	log "Certificate $cert revoked"
else
	log_error "Couldn't revoke $cert"
fi

