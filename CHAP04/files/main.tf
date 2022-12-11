terraform {
  required_version = "~> 1.2"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.2"
    }
  }
}

resource "local_file" "myfile" {
  content  = "This is my text"
  filename = "../mytextfile.txt"
}
