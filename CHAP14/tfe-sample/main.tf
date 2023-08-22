terraform {
  required_version = "~> 1.0"
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.45.0"
    }
     random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
  cloud {
    hostname     = "app.terraform.io"
    organization = "demo-tfe"

    workspaces {
      name = "manage-tfe"
    }
  }
}

provider "tfe" {
}


resource "random_string" "random" {
  length  = 4
  special = false
  upper   = false
}

resource "tfe_organization" "test-organization" {
  name  = "demo-tfe-book-${random_string.random.result}"
  email = "admin@company.com"
}

resource "tfe_project" "project" {
  organization = tfe_organization.test-organization.name
  name         = "appproject"
}

resource "tfe_workspace" "network" {
  name         = "network"
  organization = tfe_organization.test-organization.name
}

resource "tfe_workspace" "vm" {
  name         = "vm"
  organization = tfe_organization.test-organization.name
}

