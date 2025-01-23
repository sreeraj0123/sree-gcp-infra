/* No space around =
gcloud config set project sree-gcp-dev
export TF_VAR_project_id="sree-gcp-dev"
export TF_VAR_project_number="49316739423"
export TF_VAR_region="us-central1"
echo $TF_VAR_project_id
echo $TF_VAR_project_number
echo $TF_VAR_region

#bucket_name = "should be unique"
*/



vpc_name = "spn-vpc"
subnet_name = "spn-subnet"
#subnet_region = "us-central1"
subnet_ip_range = "10.129.0.0/20"

artifact_repository_id = "spn-art"

secret_id_db_user = "db-user"
secret_id_db_password = "db-password"

sql_instance_name = "spn-sql"
sql_db_name = "spn-db"

cloud_run_sa_name = "sa-cloud-run"
cicd_sa_id_app = "sa-cicd-app"
cloud_run_sa_role_list = [
  "roles/secretmanager.secretAccessor",
  "roles/cloudsql.client",
]

# infra-service-account@win-gke-cicd.iam.gserviceaccount.com
#wi_sa_id = "projects/${var.project_id}/serviceAccounts/infra-service-account@win-gke-cicd.iam.gserviceaccount.com"
/*
wi_sa_id = "infra-service-account"
#wi_sa_id = "projects/${var.project_id}/serviceAccounts/infra-service-account@${var.project_id}.iam.gserviceaccount.com"
wi_pool_id = "app-github-cicd-pool"
wi_pool_name = "app-github-cicd-pool"
wi_pool_provider_id = "app-github-provider"
#
github_repository      = "Mon8Cats/win-gke-app"
github_account         = "Mon8Cats"  # Optional if needed
github_repo_only  = "win-gke-infra"

#
environment     = "dev"
business_division = "AppDev"
/*
subnet_ip_range  = "10.128.0.0/20"
pods_ip_range    = "10.1.0.0/21"
services_ip_range = "10.2.0.0/21"
master_ip_range  = "10.3.0.0/28"
*/

