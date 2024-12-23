terraform {

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0" # Specify the version you want to use
    }
  }

  backend "gcs" {
      bucket  = "sree-tf-backends"  # Replace with your bucket name
      prefix  = "terraform/state"       # Folder to store state files
      project = "sree-gcp-dev"        # Your GCP project ID
    }

  required_version = ">= 1.3.0" # Ensure Terraform CLI version compatibility
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone # Optional if your resources require a specific zone
}
