locals {
  wip_name_unique = "wip"
  wip_id = "${local.wip_name_unique}-${var.project_number}"

  #
  //wi_pool_provider_id_infra = "${local.wi_pool_name_unique}-prid-infra-${var.project_number}"
  wip_pid_infra =  "${local.wip_name_unique}-pid-infra-${var.project_number}"
  github_acct_repo_infra = "${var.github_account}/${var.github_repo_infra}"
  github_repo_uri_infra = "https://github.com/${local.github_acct_repo_infra}.git"
  #cicd_sa_email_infra = "${var.cicd_sa_id_infra}@${var.project_id}.iam.gserviceaccount.com" 
  #
  //wi_pool_provider_id_app = "${local.wi_pool_name_unique}-prid-app-${var.project_number}"
  wip_pid_app =  "${local.wip_name_unique}-pid-app-${var.project_number}"
  github_acct_repo_app = "${var.github_account}/${var.github_repo_app}"
  github_repo_uri_app = "https://github.com/${local.github_acct_repo_app}.git"
  #cicd_sa_email_app = "${var.cicd_sa_id_app}@${var.project_id}.iam.gserviceaccount.com" 

}

# do manually enable?
# gcloud services enable iam.googleapis.com --project=spn-run ?
resource "google_project_service" "iam" {
  project = var.project_id
  service = "iam.googleapis.com"
}

module "service_apis" {
  source                  = "../../modules/a1_service_apis"
  project_id  = var.project_id
  api_services = var.api_list
}

module "secret_manager_wrapper" {
  source  = "../../modules/e9_secret_manager_wrapper"
  project_id          = var.project_id
  project_number = var.project_number
  secret_id_github  = var.secret_id_github
  secret_data_github = var.secret_data_github
  secret_id_db_user = var.secret_id_db_user
  secret_data_db_user = var.secret_data_db_user
  secret_id_db_password = var.secret_id_db_password
  secret_data_db_password = var.secret_data_db_password

  depends_on = [ module.service_apis ]
}

module "github_connection" {
  source = "../../modules/g1_cloudbuild_github_connection"
  project_id               = var.project_id
  region                   = var.region
  app_installation_id_github = var.app_installation_id_github
  secret_id_github = var.secret_id_github
  connection_name_github = var.connection_name_github

  depends_on = [ module.secret_manager_wrapper ]
}

module "workload_identity_pool" {
  source = "../../modules/g2_workload_identity_pool"
  project_id   = var.project_id
  wi_pool_id = local.wip_id
  wi_pool_name= local.wip_name_unique
}



module "cicd_pipeline_infra" {
  source = "../../modules/g9_cloudbuild_cicd_pipeline_wrapper"
  project_id = var.project_id
  region = var.region
  cicd_sa_id = var.cicd_sa_id_infra
  cicd_sa_role_list =  var.cicd_sa_role_list_infra
  cicd_log_bucket = var.cicd_log_bucket_infra
  #
  secret_id_github_token = var.secret_id_github
  secret_id_db_user = var.secret_id_db_user
  secret_id_db_password = var.secret_id_db_password
  #
  wip_name = module.workload_identity_pool.wip_name
  wip_short_id = module.workload_identity_pool.wip_short_id
  wip_provider_id = local.wip_pid_infra
  wip_provider_display_name = "wip-infra"
  github_acct_repo = local.github_acct_repo_infra
  #
  repo_name_gcp = var.github_repo_infra
  repo_uri_remote = local.github_repo_uri_infra
  repo_connection_name = module.github_connection.connection_name
} 

module "cicd_pipeline_app" {
  source = "../../modules/g9_cloudbuild_cicd_pipeline_wrapper"
  project_id = var.project_id
  region = var.region
  cicd_sa_id = var.cicd_sa_id_app
  cicd_sa_role_list =  var.cicd_sa_role_list_app
  cicd_log_bucket = var.cicd_log_bucket_app
  #
  secret_id_github_token = var.secret_id_github
  secret_id_db_user = var.secret_id_db_user
  secret_id_db_password = var.secret_id_db_password
  #
  wip_name = module.workload_identity_pool.wip_name
  wip_short_id = module.workload_identity_pool.wip_short_id
  wip_provider_id = local.wip_pid_app
  wip_provider_display_name = "wip-infra"
  github_acct_repo = local.github_acct_repo_app
  #
  repo_name_gcp = var.github_repo_app
  repo_uri_remote = local.github_repo_uri_app
  repo_connection_name = module.github_connection.connection_name
} 