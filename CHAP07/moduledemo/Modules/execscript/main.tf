terraform {
  required_version = "~> 1.1"
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }
  }
}
resource "null_resource" "execfile" {
  provisioner "local-exec" {
    command     = "${path.module}/script.sh"
    interpreter = ["/bin/bash"]
  }
}