#!/bin/bash
directory=CertificateAuthCA
index_file=$directory/db/index.txt
serial_file=$directory/db/serial
newcerts_dir=$directory/db/newcerts
key_bits=4096
key_type=rsa:$key_bits
# CA
ca_cert_key=$directory/db/ca.key
ca_cert_csr=$directory/db/ca.csr
ca_cert_crt=$directory/db/ca.crt
# Server
server_cert_key=$directory/db/server.key
server_cert_csr=$directory/db/server.csr
server_cert_crt=$directory/db/server.crt
server_cert_subject=/C=RU/ST=Moscow/L=Moscow/O=Companyname/OU=SBT/CN=SBTetc/emailAddress=support@site.com
# Client
client_cert_path=$directory/db
