# Terraform Settings Block
terraform {
  required_version = ">= 1.5.7"
  required_providers {
    google = {
      source = "hashicorp/google"
      version = ">= 6.0.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 6.0.0"
    }
  }
  # no backend
     backend "gcs" {
    bucket  = "skyroot-tf-backend"  # The GCS bucket name, cannot use variable
    prefix  = "terraform/state/secrets"  # Path to the state file within the bucket (use different paths for different environments)
    #project = var.project_id    # The GCP project ID
  }
}

# Terraform Provider Block
provider "google" {
  project = var.project_id
  region = var.region
}

provider "google-beta" {
  alias   = "beta"
  project = var.project_id
  region  = var.region
}
