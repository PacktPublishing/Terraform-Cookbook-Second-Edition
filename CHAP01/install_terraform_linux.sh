TERRAFORM_VERSION="1.2.5"
resp=$(curl -sS https://api.releases.hashicorp.com/v1/releases/terraform/${TERRAFORM_VERSION})
binaryUrl=$(echo $resp | jq -r '.builds[] | select (.os == "linux" and .arch == "amd64") | .url')
wget $binaryUrl
unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin