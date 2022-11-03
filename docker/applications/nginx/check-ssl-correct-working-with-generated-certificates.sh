#!/bin/bash
source ../../../lib.sh
cmd="curl -v --cacert CertificateAuthCA/ca.crt --cert CertificateAuthCA/client.crt --key CertificateAuthCA/client.key https://127.0.0.1:8443/"
log "Checking command [" $cmd "] in positive scenario"
if bash -c "$cmd"; then log OK; else log_error FAIL; fi

cmd="curl -v --cacert CertificateAuthCA/ca.crt https://127.0.0.1:8443/"
log "Check comand [$cmd] in negative scenarion"
if bash -c "$cmd"; then log_error FAIL; else log OK; fi
 
