variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  type        = string
  description = "ID of the GitHub token secret in Secret Manager"
}


variable "cicd_sa_name" {
  type        = string
  description = "The ID of the service account to create (must be unique within the project)"

}

variable "cicd_sa_role_list" {
  type        = list(string)
  description = "A list of service account roles"
}





variable "wi_pool_id" {
  description = "Id of the workload idenitity pool"
  type        = string
}

variable "wi_pool_name" {
  description = "name of the workload idenitity pool"
  type        = string
}

variable "wi_pool_provider_id" {
  description = "Id of the workload idenitity provider"
  type        = string
}

variable "github_repository" {
  description = "Name of the github_repository"
  type        = string
}

