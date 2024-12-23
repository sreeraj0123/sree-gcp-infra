variable "project_id" {
  description = "The GCP project ID where the Cloud SQL instance will be created."
  type        = string
}

variable "region" {
  description = "The region where the Cloud SQL instance will be created."
  type        = string
  default     = "us-central1"
}

variable "instance_name" {
  description = "The name of the Cloud SQL instance."
  type        = string
  default     = "quickstart-instance"
}

variable "database_version" {
  description = "The version of the database."
  type        = string
  default     = "MYSQL_8_0"
}

variable "tier" {
  description = "The machine type tier for the instance (e.g., db-f1-micro, db-n1-standard-1)."
  type        = string
  default     = "db-g1-small" # 1 CPU, 4GB RAM equivalent
}

variable "root_password" {
  description = "The root password for the database."
  type        = string
  sensitive   = true
}
