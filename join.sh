#!/bin/sh

export OSN_TLS_CA_ROOT_CERT=organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt
export ADMIN_TLS_SIGN_CERT=organizations/ordererOrganizations/example.com/users/Admin@example.com/tls/client.crt
export ADMIN_TLS_PRIVATE_KEY=organizations/ordererOrganizations/example.com/users/Admin@example.com/tls/client.key


osnadmin channel join --channelID channel1 --config-block genesis_block.pb -o orderer.example.com:7443 --ca-file $OSN_TLS_CA_ROOT_CERT --client-cert $ADMIN_TLS_SIGN_CERT --client-key $ADMIN_TLS_PRIVATE_KEY


osnadmin channel list --channelID channel1 -o orderer.example.com:7443 --ca-file $OSN_TLS_CA_ROOT_CERT --client-cert $ADMIN_TLS_SIGN_CERT --client-key $ADMIN_TLS_PRIVATE_KEY



export OSN_TLS_CA_ROOT_CERT=organizations/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/ca.crt
export ADMIN_TLS_SIGN_CERT=organizations/ordererOrganizations/example.com/users/Admin@example.com/tls/client.crt
export ADMIN_TLS_PRIVATE_KEY=organizations/ordererOrganizations/example.com/users/Admin@example.com/tls/client.key


osnadmin channel join --channelID channel1 --config-block genesis_block.pb -o orderer2.example.com:9443 --ca-file $OSN_TLS_CA_ROOT_CERT --client-cert $ADMIN_TLS_SIGN_CERT --client-key $ADMIN_TLS_PRIVATE_KEY


export OSN_TLS_CA_ROOT_CERT=organizations/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/ca.crt
export ADMIN_TLS_SIGN_CERT=organizations/ordererOrganizations/example.com/users/Admin@example.com/tls/client.crt
export ADMIN_TLS_PRIVATE_KEY=organizations/ordererOrganizations/example.com/users/Admin@example.com/tls/client.key


osnadmin channel join --channelID channel1 --config-block genesis_block.pb -o orderer3.example.com:11443 --ca-file $OSN_TLS_CA_ROOT_CERT --client-cert $ADMIN_TLS_SIGN_CERT --client-key $ADMIN_TLS_PRIVATE_KEY
