#!/bin/bash
echo "Install Bluemix CLI"
bluemix_scripts/install_bx.sh
if [ $? -ne 0 ]; then
  echo "Failed to install Bluemix Container Service CLI prerequisites"
  exit 1
fi

echo "Login to Bluemix"
bluemix_scripts/bx_login.sh
if [ $? -ne 0 ]; then
  echo "Failed to authenticate to Bluemix Container Service"
  exit 1
fi

echo "Deploy pods"
bluemix_scripts/deploy.sh
if [ $? -ne 0 ]; then
  echo "Failed to Deploy pods to Bluemix Container Service"
  exit 1
fi
