#!/bin/bash

# Importing useful functions for cc testing
if [ -f ./func.sh ]; then
 source ./func.sh
elif [ -f scripts/func.sh ]; then
 source scripts/func.sh
fi

#Query on chaincode on Org1/Peer0
echo_g "=== Testing Chaincode invoke/query ==="

echo_b "Querying chaincode ${CC_NAME} on peer org1/peer0..."
chaincodeQuery ${APP_CHANNEL} 1 0 ${CC_NAME} ${CC_QUERY_ARGS} 100

#Invoke on chaincode on Org1/Peer0
echo_b "Sending invoke transaction (transfer 10) on org1/peer0..."
chaincodeInvoke ${APP_CHANNEL} 1 0 ${CC_NAME} ${CC_INVOKE_ARGS}

#Query on chaincode on Org2/Peer1, check if the result is 90
echo_b "Querying chaincode on all 4peers..."
chaincodeQuery ${APP_CHANNEL} 1 0 ${CC_NAME} ${CC_QUERY_ARGS} 90
chaincodeQuery ${APP_CHANNEL} 2 0 ${CC_NAME} ${CC_QUERY_ARGS} 90
chaincodeQuery ${APP_CHANNEL} 1 1 ${CC_NAME} ${CC_QUERY_ARGS} 90
chaincodeQuery ${APP_CHANNEL} 2 1 ${CC_NAME} ${CC_QUERY_ARGS} 90

#Invoke on chaincode on Org2/Peer1
echo_b "Sending invoke transaction on org2/peer1..."
chaincodeInvoke ${APP_CHANNEL} 2 1 ${CC_NAME} ${CC_INVOKE_ARGS}

#Query on chaincode on Org2/Peer1, check if the result is 80
echo_b "Querying chaincode on all 4peers..."
chaincodeQuery ${APP_CHANNEL} 1 0 ${CC_NAME} ${CC_QUERY_ARGS} 80
chaincodeQuery ${APP_CHANNEL} 2 0 ${CC_NAME} ${CC_QUERY_ARGS} 80
chaincodeQuery ${APP_CHANNEL} 1 1 ${CC_NAME} ${CC_QUERY_ARGS} 80
chaincodeQuery ${APP_CHANNEL} 2 1 ${CC_NAME} ${CC_QUERY_ARGS} 80

echo_g "=== Chaincode invoke/query completed ==="

echo
