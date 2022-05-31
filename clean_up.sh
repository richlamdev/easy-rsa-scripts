#!/bin/bash
#
# For use with easy-rsa:
# https://github.com/OpenVPN/easy-rsa
#
# deploy this file where the easyrsa script is located.
# eg: easy-rsa/easyrsa3/clean_up.sh

echo "Removing all previously created Certificate Authorities and Cerfiticates"
echo

rm -rfi pki
rm -rfi certs/*
#./easyrsa init-pki hard-reset

exit 0
