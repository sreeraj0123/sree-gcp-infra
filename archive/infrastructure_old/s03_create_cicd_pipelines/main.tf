# (1) enable apis
module "enable_apis" {
  source     = "../../modules/a01_gcp_service_apis"
  project_id = var.project_id
  api_services = var.api_list
}

module "secret_iam_binding" {
  source                = "../../modules/b03b_gcp_secret_iam_binding"
  project_id            = var.project_id
  secret_id           = var.secret_id_github # to make github connection
  service_account_email = local.cloud_build_sa_email
  #"service-${var.project_number}@gcp-sa-cloudbuild.iam.gserviceaccount.com"
  role                  = "roles/secretmanager.secretAccessor"
}


module "github_connection" {
  source = "../../modules/c01_gcp_cloudbuild_github_connection"

  project_id               = var.project_id
  region                   = var.region
  github_app_installation_id = var.installation_id_github_app
  connection_name = var.connection_name_github
  secret_id = var.secret_id_github

}

module "cicd_pipeline_infra" {
  source = "../../modules/c09_gcp_cicd_pipeline"
  project_id = var.project_id
  region = var.region
  cicd_sa_name = var.cicd_sa_infra
  cicd_sa_role_list = var.cicd_sa_infra_role_list
  bucket_name = var.logs_bucket_infra
  wi_pool_id = local.wi_pool_id_infra
  wi_pool_name = local.wi_pool_name_infra
  wi_pool_provider_id = local.wi_pool_provider_id_infra
  github_repository = local.github_acct_repo_infra
  github_secret_id = var.secret_id_github
  connection_parent = module.github_connection.connection_name
  repo_name_gcp = var.gcp_repo_infra
  repo_uri_remote = local.github_uri_infra

  depends_on   = [module.github_connection]
}

module "secret_access_db_user_infra" {
  source              = "../../modules/b03_gcp_secret_iam_member"
  secret_id = var.secret_id_db_user
  service_account_email = module.cicd_pipeline_infra.service_account_email
}

module "secret_access_db_password_infra" {
  source              =  "../../modules/b03_gcp_secret_iam_member"
  secret_id = var.secret_id_db_password
  service_account_email = module.cicd_pipeline_infra.service_account_email
}

/*
module "grant_member_secret_access_infra" {
  source    =  "../../modules/b03a_gcp_multiple_secrets_iam_member"
  member    =  module.cicd_pipeline_infra.service_account_email
  secret_ids = [
    var.secret_id_db_user,
    var.secret_id_db_password
  ]
  role      = "roles/secretmanager.secretAccessor"

  depends_on   = [module.cicd_pipeline_infra]
}
*/

module "cicd_pipeline_app" {
  source = "../../modules/c09_gcp_cicd_pipeline"
  project_id = var.project_id
  region = var.region
  cicd_sa_name = var.cicd_sa_app
  cicd_sa_role_list = var.cicd_sa_app_role_list
  bucket_name = var.logs_bucket_app
  wi_pool_id = local.wi_pool_id_app
  wi_pool_name = local.wi_pool_name_app
  wi_pool_provider_id = local.wi_pool_provider_id_app
  github_repository = local.github_acct_repo_app
  github_secret_id = var.secret_id_github
  connection_parent = module.github_connection.connection_name
  repo_name_gcp = var.gcp_repo_app
  repo_uri_remote = local.github_uri_app

  depends_on   = [module.github_connection]
}


module "secret_access_db_user_app" {
  source              = "../../modules/b03_gcp_secret_iam_member"
  secret_id = var.secret_id_db_user
  service_account_email = module.cicd_pipeline_app.service_account_email
}

module "secret_access_db_password_app" {
  source              =  "../../modules/b03_gcp_secret_iam_member"
  secret_id = var.secret_id_db_password
  service_account_email = module.cicd_pipeline_app.service_account_email
}

/*
module "grant_member_secret_access_app" {
  source    =  "../../modules/b03a_gcp_multiple_secrets_iam_member"
  member    =  module.cicd_pipeline_app.service_account_email
  secret_ids = [
    var.secret_id_db_user,
    var.secret_id_db_password
  ]
  role      = "roles/secretmanager.secretAccessor"

  depends_on   = [module.cicd_pipeline_app]
}
*/


# create a service account for cloud run
module "cloud_run_service_account" {
  source               = "../../modules/a03_gcp_service_account"
  project_id           = var.project_id
  service_account_name = var.cloud_run_sa
  display_name         = "Cloud Run Service Account"
  description          = "This service account is used for cloud run service"

  roles = var.cloud_run_sa_role_list

}

module "cloud_run_iam_binding" {
  source       = "../../modules/a03a_gcp_service_account_iam_binding"
  project_id   = var.project_id
  cloud_run_sa = local.cloud_run_sa_email
  cicd_sa      = local.cicd_sa_app_email

   depends_on   = [module.cicd_pipeline_app, module.cloud_run_service_account]
}
