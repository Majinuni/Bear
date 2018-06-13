#!/bin/bash

echo "Download Bluemix CLI"
wget --quiet --output-document=/tmp/Bluemix_CLI_amd64.tar.gz  http://public.dhe.ibm.com/cloud/bluemix/cli/bluemix-cli/latest/Bluemix_CLI_amd64.tar.gz
tar -xf /tmp/Bluemix_CLI_amd64.tar.gz --directory=/tmp

export PATH="/tmp/Bluemix_CLI/bin:$PATH"

# Install Armada CS plugin
echo "Install the Bluemix container-service plugin"
bluemix plugin install container-service -r Bluemix

echo "Install kubectl"
wget --quiet --output-document=/tmp/Bluemix_CLI/bin/kubectl  https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x /tmp/Bluemix_CLI/bin/kubectl

if [ -n "$DEBUG" ]; then
  bluemix --version
  bluemix plugin list
fi
