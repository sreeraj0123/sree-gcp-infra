variable "project_id" {
  description = "The ID of the GCP project where the bucket will be created."
  type        = string
}

variable "bucket_name" {
  description = "The name of the bucket to create."
  type        = string
}

variable "location" {
  description = "The GCP region where the bucket will be created."
  type        = string
  default     = "US"
}

variable "storage_class" {
  description = "The storage class of the bucket."
  type        = string
  default     = "STANDARD"
}

variable "force_destroy" {
  description = "When set to true, the bucket and all its contents will be deleted on destroy."
  type        = bool
  default     = false
}
