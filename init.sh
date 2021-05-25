#!/bin/sh

#export env

export PATH=/root/go/src/github.com/hyperledger/fabric-samples/bin:$PATH
export FABRIC_CFG_PATH=/root/go/src/github.com/hyperledger/fabric-samples/config/

export CORE_PEER_TLS_ENABLED=true

export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/root/go/src/github.com/hyperledger/fabric-samples/without-sys-channel-network/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/root/go/src/github.com/hyperledger/fabric-samples/without-sys-channel-network/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051


#peer0.org1 join channel
peer channel join -b genesis_block.pb

# export peer0.org2 env
export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/root/go/src/github.com/hyperledger/fabric-samples/without-sys-channel-network/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/root/go/src/github.com/hyperledger/fabric-samples/without-sys-channel-network/organizations/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
export CORE_PEER_ADDRESS=peer0.org2.example.com:9051

#peer0.org2 join channel
peer channel join -b genesis_block.pb

#export peer0.org1 env
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/root/go/src/github.com/hyperledger/fabric-samples/without-sys-channel-network/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/root/go/src/github.com/hyperledger/fabric-samples/without-sys-channel-network/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051

peer lifecycle chaincode package sacc.tar.gz --path chaincode/sacc --lang golang --label sacc_1.0

#install chaincode on peer0.org1
peer lifecycle chaincode install sacc.tar.gz 

# export peer0.org2 env
export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/root/go/src/github.com/hyperledger/fabric-samples/without-sys-channel-network/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/root/go/src/github.com/hyperledger/fabric-samples/without-sys-channel-network/organizations/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
export CORE_PEER_ADDRESS=peer0.org2.example.com:9051

#install chaincode on peer0.org2
peer lifecycle chaincode install sacc.tar.gz 

#export peer0.org1 env
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/root/go/src/github.com/hyperledger/fabric-samples/without-sys-channel-network/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/root/go/src/github.com/hyperledger/fabric-samples/without-sys-channel-network/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051

peer lifecycle chaincode queryinstalled

#export peer0.org1 env
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/root/go/src/github.com/hyperledger/fabric-samples/without-sys-channel-network/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/root/go/src/github.com/hyperledger/fabric-samples/without-sys-channel-network/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051

peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt --channelID channel1 --name sacc --version 1.0 --package-id sacc_1.0:1ec5f659f7b95978829202e4201cd969ccb0952a9c87a1bb51c9588b518923a1 --sequence 1 --init-required

export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/root/go/src/github.com/hyperledger/fabric-samples/without-sys-channel-network/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/root/go/src/github.com/hyperledger/fabric-samples/without-sys-channel-network/organizations/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
export CORE_PEER_ADDRESS=peer0.org2.example.com:9051

peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt --channelID channel1 --name sacc --version 1.0 --package-id sacc_1.0:1ec5f659f7b95978829202e4201cd969ccb0952a9c87a1bb51c9588b518923a1 --sequence 1 --init-required

peer lifecycle chaincode checkcommitreadiness -o orderer.example.com:7050 --channelID channel1 --tls --cafile organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt --name sacc --version 1.0 --init-required --sequence 1

#export peer0.org1 env
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/root/go/src/github.com/hyperledger/fabric-samples/without-sys-channel-network/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/root/go/src/github.com/hyperledger/fabric-samples/without-sys-channel-network/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051

peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt --channelID channel1 --name sacc --peerAddresses peer0.org1.example.com:7051 --tlsRootCertFiles /root/go/src/github.com/hyperledger/fabric-samples/without-sys-channel-network/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses peer0.org2.example.com:9051 --tlsRootCertFiles /root/go/src/github.com/hyperledger/fabric-samples/without-sys-channel-network/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt --version 1.0 --sequence 1 --init-required 

peer lifecycle chaincode querycommitted --channelID channel1 --name sacc

peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C channel1 -n sacc --peerAddresses localhost:7051 --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses localhost:9051 --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt --isInit -c '{"Args":["a","10"]}'

peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C channel1 -n sacc --peerAddresses localhost:7051 --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses localhost:9051 --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt -c '{"function":"set","Args":["a","20"]}'

peer chaincode query -C channel1 -n sacc -c '{"Args":["get","a"]}'


