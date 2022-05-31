#!/bin/bash
#
# For use with easy-rsa:
# https://github.com/OpenVPN/easy-rsa

# deploy this file where the easyrsa script is located.
# eg: easy-rsa/easyrsa3/make_certs.sh
#
# This is a quick dirty method to generate a server certificate for AWS ACM.
# The AWS Client VPN, regardless of authentication method, requires an ARN reference from AWS ACM.
#
# Change the SERVER_CERT_NAME variable according to environment. (or whatever arbitrary value you desire!)
#
# This script is based on the instructions located here:
# https://docs.aws.amazon.com/vpn/latest/clientvpn-admin/client-authentication.html

#uncomment for troubleshooting
#set -x

# Initialize a new PKI environment.
./easyrsa init-pki

# To build a new certificate authority (CA), run this command and follow the prompts.
./easyrsa build-ca nopass

# Generate the server certificate and key. No spaces are permitted in the server name.
SERVER_CERT_NAME="Middle_Earth_Production"
./easyrsa build-server-full $SERVER_CERT_NAME nopass

# Generate the client certificate and key.
# Save the client cert and private key, they are needed to configure the client.
# Will need to create a loop and variables for multiple client cert creation/management.
#./easyrsa build-client-full client1.domain.tld nopass

# copies required certificates (files) to $CERT_DIR
# upload the certs to AWS ACM as needed.  
# client certs are only required for certifcation based authentication.
CERT_DIR=certs

mkdir -pv $CERT_DIR
cp pki/ca.crt $CERT_DIR
cp pki/issued/${SERVER_CERT_NAME}.crt $CERT_DIR
cp pki/private/${SERVER_CERT_NAME}.key $CERT_DIR

# copy client cert and private key to $CERT_DIR
#cp pki/issued/client1.domain.tld.crt $CERT_DIR
#cp pki/private/client1.domain.tld.key $CERT_DIR

exit 0
