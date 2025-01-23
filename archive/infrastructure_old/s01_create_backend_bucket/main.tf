module "service_apis" {
  source                  = "../../modules/a01_gcp_service_apis"
  project_id  = var.project_id
  api_services = var.api_list
}

module "terraform_backend_storage_bucket" {
  source                  = "../../modules/a02_gcp_storage_bucket"
  project_id              = var.project_id
  bucket_name             = var.bucket_name
  location                = var.region  #"US", "EU", "ASIA" multi-regional bucket
  storage_class           = "STANDARD" # Nearline, Coldline, Archive
  versioning_enabled      = true
  enable_retention_policy = true
  retention_period_days   = 30
  retention_policy_locked = false
  lifecycle_rules = [
    {
      action_type = "Delete"
      condition   = { age = 365 }
    }
  ]

  depends_on   = [module.service_apis]
}
