#!/bin/bash
directory=CertificateAuthCA
# CA
ca_cert_key=$directory/db/ca.key
ca_cert_csr=$directory/db/ca.csr
ca_cert_crt=$directory/db/ca.crt
# Server
server_cert_key=$directory/db/server.key
server_cert_csr=$directory/db/server.csr
server_cert_crt=$directory/db/server.crt
server_cert_subject=/C=RU/ST=Moscow/L=Moscow/O=Companyname/OU=SBT/CN=SBTetc/emailAddress=support@site.com
