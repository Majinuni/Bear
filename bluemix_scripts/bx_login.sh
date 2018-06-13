if [ -z $CF_ORG ]; then
  CF_ORG="$BLUEMIX_ORG"
fi
if [ -z $CF_SPACE ]; then
  CF_SPACE="$BLUEMIX_SPACE"
fi


if [ -z "$BLUEMIX_API_KEY" ]; then
  echo "Define all required environment variables and rerun the stage."
  exit 1
fi
echo "Deploy pods"

echo "bluemix login -a $CF_TARGET_URL"
bluemix login -a "$CF_TARGET_URL" --apikey "$BLUEMIX_API_KEY"
if [ $? -ne 0 ]; then
  echo "Failed to authenticate to Bluemix"
  exit 1
fi

echo "Container Registry Login"
bx cr login
if [ $? -ne 0 ]; then
  echo "Failed to authenticate to Bluemix Container Registry"
  exit 1
fi

# Init container clusters
echo "bluemix cs init"
bluemix cs init
if [ $? -ne 0 ]; then
  echo "Failed to initialize to Bluemix Container Service"
  exit 1
fi
