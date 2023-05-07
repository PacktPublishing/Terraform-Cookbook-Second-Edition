terraform {
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.4"
    }
    pkcs12 = {
      source  = "chilicat/pkcs12"
      version = "0.0.7"
    }
  }
}

# Create a private key in PEM format
resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

# Generates a TLS self-signed certificate using the private key
resource "tls_self_signed_cert" "self_signed_cert" {
  private_key_pem = tls_private_key.private_key.private_key_pem

  validity_period_hours = 120

  subject {
    # The subject CN field here contains the hostname to secure
    common_name = "test.com"
  }

  allowed_uses = [
    "digital_signature",
    "cert_signing",
    "crl_signing",
  ]

}

resource "local_file" "ca_key" {
  content  = tls_private_key.private_key.private_key_pem
  filename = "${path.module}/ca.key"
}

resource "local_file" "ca_cert" {
  content  = tls_self_signed_cert.self_signed_cert.cert_pem
  filename = "${path.module}/ca.pem"
}


# To convert the PEM certificate in PFX we need a password
resource "random_password" "self_signed_cert" {
  length  = 24
  special = true
}

# This resource converts the PEM certicate in PFX
resource "pkcs12_from_pem" "self_signed_cert_pkcs12" {
  cert_pem        = tls_self_signed_cert.self_signed_cert.cert_pem
  private_key_pem = tls_private_key.private_key.private_key_pem
  password        = random_password.self_signed_cert.result
}

resource "local_file" "result" {
  filename       = "${path.module}/ca.pxf"
  content_base64 = pkcs12_from_pem.self_signed_cert_pkcs12.result
}