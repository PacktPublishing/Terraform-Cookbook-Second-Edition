TERRAFORM_VERSION=1.2.5

# This is the public key from above - one-time step.
gpg --import hashicorp.asc

# Download the archive and signature files.
curl -Os https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
curl -Os https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS
curl -Os https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS.sig

# Verify the signature file is untampered.
gpg --verify terraform_${TERRAFORM_VERSION}_SHA256SUMS.sig terraform_${TERRAFORM_VERSION}_SHA256SUMS

# Verify the SHASUM matches the archive.
shasum -a 256 -c terraform_${TERRAFORM_VERSION}_SHA256SUMS