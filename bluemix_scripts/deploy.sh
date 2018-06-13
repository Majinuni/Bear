#!/bin/bash

echo "Create Application"
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
bx cr build . --tag registry.ng.bluemix.net/test_api_registry_namespace/ibm_water_hackathon_bear:v$TRAVIS_BUILD_NUMBER

echo -e "Creating pods"
envsubst < kubernetes/deployments/python.yml | kubectl apply -f -
kubectl apply -f kubernetes/deployments/postgis.yml

echo -e "Creating Load Balancer"
kubectl apply -f kubernetes/services/python.yml
kubectl apply -f kubernetes/services/postgis.yml

kubectl get pods

PORT=$(kubectl get services | grep frontend | sed 's/.*:\([0-9]*\).*/\1/g')

echo "View the application at http://$IP_ADDR:$PORT"

echo "Running pods"
kubectl get pods --field-selector=status.phase=Running

echo "Describe Deployments"

kubectl describe deployments python-app-deployment
kubectl describe deployments postgis-deployment


echo "Describe Services"

kubectl describe services postgis-service
kubectl describe services python-service

printenv
