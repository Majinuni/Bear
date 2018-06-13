#!/bin/bash

echo "Create Guestbook"
IP_ADDR=$(bluemix cs workers $CLUSTER_NAME | grep normal | awk '{ print $2 }')
if [ -z $IP_ADDR ]; then
  echo "$CLUSTER_NAME not created or workers not ready"
  exit 1
fi

echo -e "Configuring vars"
exp=$(bluemix cs cluster-config $CLUSTER_NAME | grep export)
if [ $? -ne 0 ]; then
  echo "Cluster $CLUSTER_NAME not created or not ready."
  exit 1
fi
eval "$exp"

echo "Build Docker Image for Application"
bx cr build . --tag registry.ng.bluemix.net/test_api_registry_namespace/ibm_water_hackathon_bear:0.1.0

echo -e "Creating pods"
kubectl create -f kubernetes/deployments/python.yml

echo -e "Creating Load Balancer"
kubectl create -f kubernetes/services/python.yml

PORT=$(kubectl get services | grep frontend | sed 's/.*:\([0-9]*\).*/\1/g')

echo ""
echo "View the application at http://$IP_ADDR:$PORT"
