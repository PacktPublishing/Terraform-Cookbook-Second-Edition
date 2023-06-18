terraform {
  required_version = ">= 1.1.0"
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.45.0"
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

resource "tfe_organization" "test-organization" {
  name  = "demo-tfe-book"
  email = "admin@company.com"
}

resource "tfe_project" "project" {
  organization = tfe_organization.test-organization.name
  name         = "appproject"
}

resource "tfe_workspace" "wsnetwork" {
  name         = "network"
  organization = tfe_organization.test-organization.name
}

resource "tfe_workspace" "wsvm" {
  name         = "vm"
  organization = tfe_organization.test-organization.name
}

