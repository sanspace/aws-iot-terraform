terraform {
  required_version = "~> 1.6.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.default_region
  # pick the profile matching current workspace name
  profile = var.use_default_creds ? "default" : terraform.workspace
}
