variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}

variable "instance_name" {
  description = "Cloud SQL Instance Name"
  type        = string
}

variable "database_version" {
  description = "MySQL database version (e.g., MYSQL_8_0)"
  type        = string
  default     = "MYSQL_8_0"
}

variable "tier" {
  description = "Machine type tier (e.g., db-f1-micro, db-n1-standard-1)"
  type        = string
  default     = "db-f1-micro"
}

variable "disk_size" {
  description = "Disk size in GB"
  type        = number
  default     = 10
}

variable "disk_type" {
  description = "Disk type (e.g., PD_SSD, PD_HDD)"
  type        = string
  default     = "PD_SSD"
}

variable "availability_type" {
  description = "Availability type (e.g., ZONAL, REGIONAL)"
  type        = string
  default     = "ZONAL"
}

variable "backup_enabled" {
  description = "Enable backups"
  type        = bool
  default     = true
}

variable "ipv4_enabled" {
  description = "Enable public IP"
  type        = bool
  default     = true
}

variable "private_network" {
  description = "Private network for the instance (e.g., VPC network self-link)"
  type        = string
  default     = null
}

variable "require_ssl" {
  description = "Require SSL for connections"
  type        = bool
  default     = false
}

variable "databases" {
  description = "List of databases to create"
  type = list(object({
    name      = string
    charset   = string
    collation = string
  }))
  default = []
}

variable "users" {
  description = "List of database users to create"
  type = list(object({
    name     = string
    password = string
  }))
  default = []
}
