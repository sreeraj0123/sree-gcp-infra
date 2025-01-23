/*
- create a service account and assign roles
- create a wip for github with this sa


*/

module "cicd_service_account" {
  source               = "../c1_service_account"
  project_id           = var.project_id
  service_account_name = var.cicd_sa_name
  display_name         = "ci-cd service sccount"
  description          = "This service account is used for CI/CD operations"

  roles = var.cicd_sa_role_list

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


module "aaaa" {
  source           = "../c02_gcp_iam_workload_identity_pool"
  project_id = var.project_id
  wi_pool_id = var.wi_pool_id
  wi_pool_name = var.wi_pool_name
  wi_pool_provider_id = var.wi_pool_provider_id
  github_repository = var.github_repository
  service_account_id = "projects/${var.project_id}/serviceAccounts/${var.cicd_sa_name}@${var.project_id}.iam.gserviceaccount.com"

  depends_on   = [module.cicd_service_account]
}



