#!/bin/bash
source ../../../lib.sh
source init.sh
read -p "Certificate name> " cert_name
cmd="curl -v --cacert $ca_cert_crt --cert $client_cert_path/$cert_name.crt --key $client_cert_path/$cert_name.key https://127.0.0.1:8443/"
log "Checking command [$cmd] in positive scenario"
if bash -c "$cmd"; then log OK; else log_error FAIL; exit 0 ; fi

cmd="curl -v --cacert $ca_cert_crt https://127.0.0.1:8443/ | grep '400 No required SSL certificate was sent'"
log "Check comand [$cmd] in negative scenarion"
if bash -c "$cmd"; then log OK; else log_error FAIL; fi
 
