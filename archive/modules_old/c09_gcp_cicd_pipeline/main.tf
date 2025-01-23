# a service account for cicd
module "cicd_service_account" {
  source               = "../a03_gcp_service_account"
  project_id           = var.project_id
  service_account_name = var.cicd_sa_name
  display_name         = "cicd Service Account"
  description          = "This service account is used for CI/CD operations"

  roles = var.cicd_sa_role_list

}

# a build log bucket
module "build_logs_bucket" {
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

  depends_on   = [module.cicd_service_account]
}

# permission to bucket
module "build_logs_bucket_iam_binding" {
  source           = "../../modules/a02a_gcp_storage_bucket_iam_binding"
  bucket_name      = var.bucket_name
  service_account_email   = local.service_account_email
  role             = "roles/storage.objectAdmin"

  depends_on   = [module.build_logs_bucket]
}


# github token access
module "github_token_secret_access" {
  source              = "../b03_gcp_secret_iam_member"
  secret_id = var.github_secret_id
  service_account_email = module.cicd_service_account.service_account_email

  depends_on   = [module.cicd_service_account]
}


# workload_identity
module "workload_identity_pool" {
  source           = "../c02_gcp_iam_workload_identity_pool"
  project_id = var.project_id
  wi_pool_id = var.wi_pool_id
  wi_pool_name = var.wi_pool_name
  wi_pool_provider_id = var.wi_pool_provider_id
  github_repository = var.github_repository
  service_account_id = "projects/${var.project_id}/serviceAccounts/${var.cicd_sa_name}@${var.project_id}.iam.gserviceaccount.com"

  depends_on   = [module.cicd_service_account]
}

# github connection - common for all cicd pipeline


# repository link
module "github_repository_link" {
  source = "../c03_gcp_cloudbuild_repository"

  region  = var.region
  connection_parent  = var.connection_parent
  repo_name_gcp = var.repo_name_gcp
  repo_uri_remote = var.repo_uri_remote

}

# cloud build trigger - manual
