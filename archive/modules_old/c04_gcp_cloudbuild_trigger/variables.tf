variable "project_id" {
  description = "The GCP project ID where the APIs will be enabled"
  type        = string
}

variable "region" {
  description = "ID of the GitHub token secret in Secret Manager"
  type        = string
}

variable "connection_parent" {
  description = "ID of the GitHub token secret in Secret Manager"
  type        = string
}

variable "service_account" {
  description = "ID of the GitHub token secret in Secret Manager"
  type        = string
}


variable "repo_name_gcp" {
  description = "ID of the GitHub token secret in Secret Manager"
  type        = string
}

variable "repo_uri_remote" {
  description = "Custom service account email for Cloud Build"
  type        = string
}

variable "trigger_name" {
  description = "ID of the GitHub token secret in Secret Manager"
  type        = string
}

variable "cloudbuild_yaml_path" {
  description = "ID of the GitHub token secret in Secret Manager"
  type        = string
}

variable "branch_pattern" {
  description = "ID of the GitHub token secret in Secret Manager"
  type        = string
}

variable "custom_variable_1" {
  description = "ID of the GitHub token secret in Secret Manager"
  type        = string
}

variable "custom_variable_2" {
  description = "ID of the GitHub token secret in Secret Manager"
  type        = string
}

variable "custom_variable_3" {
  description = "ID of the GitHub token secret in Secret Manager"
  type        = string
}

variable "github_owner" { 
  description = "The owner of the GitHub repository" 
  type = string 
}