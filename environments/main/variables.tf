variable "project_id" {
  description = "Project ID for the GCP project"
  type        = string
}

variable "region" {
  description = "Region in which GCP Resources to be created"
  type = string
  default = "us-central1"
}



variable "vpc_name" {
  description = "Name of the VPC network"
  type        = string
}


variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}


/*
variable "subnet_region" {
  description = "Region for the subnet"
  type        = string
}
*/

variable "subnet_ip_range" {
  description = "Subnet IP range"
  type = string
  default = "10.129.0.0/20"
}

variable "artifact_repository_id" {
  description = "Artifact Repository Id"
  type        = string
}



variable "secret_id_db_user" {
  description = "The db_password secret id"
  type        = string
}

variable "secret_id_db_password" {
  description = "The db_password secret id"
  type        = string
}


variable "sql_instance_name" {
  description = "The db server instance name"
  type        = string
}

variable "sql_db_name" {
  description = "The db server instance name"
  type        = string
}

variable "cloud_run_sa_name" {
  type        = string
  description = "The ID of the service account to create (must be unique within the project)"
}

variable "cloud_run_sa_role_list" {
  type        = list(string)
  description = "A list of APIs"
  #default     = ["value1", "value2", "value3"]  # optional default value
}


variable "cicd_sa_id_app" {
  type        = string
  description = "The ID of the service account to create (must be unique within the project)"
}

/*
variable "wi_sa_id" {
  description = "The region for the resources"
  type        = string
}

variable "wi_pool_id" {
  description = "The region for the resources"
  type        = string
}

variable "wi_pool_name" {
  description = "The region for the resources"
  type        = string
}

variable "wi_pool_provider_id" {
  description = "The region for the resources"
  type        = string
}


variable "github_account" {
  description = "The GitHub Account"
  type        = string
}

variable "github_repository" {
  description = "The region for the resources"
  type        = string
}

variable "github_repo_only" {
  description = "The region for the resources"
  type        = string
}




# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = "dev"
}

# Business Division
variable "business_division" {
  description = "Business Division in the large organization this Infrastructure belongs"
  type = string
  default = "sap"
}

# CIDR IP Ranges


variable "pods_ip_range" {
  description = "Kubernetes Pods IP range"
  type = string
  default = "10.11.0.0/21"
}

variable "services_ip_range" {
  description = "Kubernetes Services IP range"
  type = string
  default = "10.12.0.0/21"
}

variable "master_ip_range" {
  description = "Kubernetes Master IP range"
  type = string
  default = "10.13.0.0/28"
}
*/

