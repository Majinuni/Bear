#!/bin/bash

echo "Download Bluemix CLI"
curl -sL https://ibm.biz/idt-installer | bash

echo "Install kubectl"
wget --quiet --output-document=/tmp/Bluemix_CLI/bin/kubectl  https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x /tmp/Bluemix_CLI/bin/kubectl

if [ -n "$DEBUG" ]; then
  bluemix --version
  bluemix plugin list
fi
