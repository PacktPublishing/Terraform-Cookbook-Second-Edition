TERRAFORM_VERSION="1.3.2"
RESP=$(curl -sS https://api.releases.hashicorp.com/v1/releases/terraform/${TERRAFORM_VERSION})
BINARY_URL=$(echo $RESP | jq -r '.builds[] | select (.os == "linux" and .arch == "amd64") | .url')
wget $BINARY_URL
unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin