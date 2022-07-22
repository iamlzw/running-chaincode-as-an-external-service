#!/bin/sh

#export env
PROJECT_PATH=$(pwd)
echo ${PROJECT_PATH}

export PATH=${PROJECT_PATH}/bin:$PATH
export FABRIC_CFG_PATH=${PROJECT_PATH}/config/

export CORE_PEER_TLS_ENABLED=true

export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PROJECT_PATH}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PROJECT_PATH}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051

peer lifecycle chaincode queryinstalled

#export peer0.org1 env
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PROJECT_PATH}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PROJECT_PATH}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051

peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${PROJECT_PATH}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt --channelID channel1 --name examplecc --version 1.0 --package-id examplecc_1.0:a960cf49097b238dbfd0b448fd0f5f376cf2964ab6c78d840de83d7f2c8592a6 --sequence 1 --init-required

export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PROJECT_PATH}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PROJECT_PATH}/organizations/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
export CORE_PEER_ADDRESS=peer0.org2.example.com:9051

peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${PROJECT_PATH}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt --channelID channel1 --name examplecc --version 1.0 --package-id examplecc_1.0:a960cf49097b238dbfd0b448fd0f5f376cf2964ab6c78d840de83d7f2c8592a6 --sequence 1 --init-required

peer lifecycle chaincode checkcommitreadiness -o orderer.example.com:7050 --channelID channel1 --tls --cafile ${PROJECT_PATH}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt --name examplecc --version 1.0 --init-required --sequence 1

#export peer0.org1 env
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PROJECT_PATH}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PROJECT_PATH}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051

peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${PROJECT_PATH}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt --channelID channel1 --name examplecc --peerAddresses peer0.org1.example.com:7051 --tlsRootCertFiles ${PROJECT_PATH}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses peer0.org2.example.com:9051 --tlsRootCertFiles ${PROJECT_PATH}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt --version 1.0 --sequence 1 --init-required 

peer lifecycle chaincode querycommitted --channelID channel1 --name examplecc

peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${PROJECT_PATH}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C channel1 -n examplecc --peerAddresses localhost:7051 --tlsRootCertFiles ${PROJECT_PATH}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses localhost:9051 --tlsRootCertFiles ${PROJECT_PATH}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt --isInit -c '{"Args":["Init","a","100","b","200"]}'

#sleep 30s to wait chaincode init success
sleep 10s

peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${PROJECT_PATH}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C channel1 -n examplecc --peerAddresses localhost:7051 --tlsRootCertFiles ${PROJECT_PATH}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses localhost:9051 --tlsRootCertFiles ${PROJECT_PATH}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt -c '{"function":"invoke","Args":["a","b","20"]}'

peer chaincode query -C channel1 -n examplecc -c '{"Args":["query","a"]}'
