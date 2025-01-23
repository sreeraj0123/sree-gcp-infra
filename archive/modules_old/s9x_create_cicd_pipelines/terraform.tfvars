/* No space around =
export TF_VAR_project_id="cog-run-lab"
export TF_VAR_project_number="146758086101"
export TF_VAR_region="us-central1"
echo $TF_VAR_project_id
echo $TF_VAR_project_number
echo $TF_VAR_region

#bucket_name = "should be unique"
*/

# (1) log buckets for Cloud Build : put them in the cloudbuild.yaml **********

logs_bucket_infra = "cog-run-infra-logs" 
logs_bucket_app = "cog-run-app-logs"


# (2) api list **********
api_list   = [
    "cloudresourcemanager.googleapis.com", # manually enabled
    "storage.googleapis.com",
    "iam.googleapis.com", # to create service account
    "cloudbuild.googleapis.com",
    "secretmanager.googleapis.com", # manually enabled
    "artifactregistry.googleapis.com",
    "sqladmin.googleapis.com",
    "compute.googleapis.com",
    "run.googleapis.com",
  ]


# (3) secrets (GitHub and DB) **********
secret_id_github = "github-token"
secret_id_db_user = "db-user"
secret_id_db_password = "db-password"

# (4) github connection, github account, repos **********
# my github account, settings/applications/configure -> check url
connection_name_github = "github-connection"
installation_id_github_app = "55957239" # from GitHub
github_account = "Mon8Cats"
github_repo_infra = "cog-run-infra"
github_repo_app = "cog-run-app"
gcp_repo_infra = "cog-run-infra"
gcp_repo_app = "cog-run-app"

prefix_name = "sk"
# (5) service accounts and roles
cicd_sa_infra = "sa-cicd-infra"
cicd_sa_app = "sa-cicd-app"
cloud_run_sa = "sa-cloud-run"

cicd_sa_infra_role_list = [
  "roles/cloudbuild.builds.editor",
  "roles/storage.admin",
  "roles/secretmanager.secretAccessor",
  "roles/iam.serviceAccountUser",
  "roles/resourcemanager.projectIamAdmin",
  "roles/viewer",
  "roles/compute.admin",
  "roles/iam.serviceAccountKeyAdmin",
  "roles/source.reader",
  "roles/cloudbuild.builds.builder",
  "roles/artifactregistry.admin",
  "roles/cloudsql.admin",
  "roles/compute.networkAdmin",
  "roles/compute.securityAdmin"
]

cicd_sa_app_role_list = [
  "roles/cloudbuild.builds.editor",
  "roles/storage.admin",
  "roles/secretmanager.secretAccessor",
  "roles/iam.serviceAccountUser",
  "roles/resourcemanager.projectIamAdmin",
  "roles/viewer",
  "roles/compute.admin",
  "roles/iam.serviceAccountKeyAdmin",
  "roles/compute.networkAdmin",
  "roles/source.reader",
  "roles/cloudbuild.builds.builder",
  "roles/serviceusage.serviceUsageAdmin",
  "roles/run.admin",
]

cloud_run_sa_role_list = [
  "roles/secretmanager.secretAccessor",
  "roles/cloudsql.client",
]

# (6) Workload Identity
/*
wi_pool_id_infra = "wi-pool-infra"
wi_pool_name_infra = "wi-pool-infra"
wi_pool_provider_id_infra = "wi-pool-provider-infra"

wi_pool_id_app = "wi-pool-app"
wi_pool_name_app = "wi-pool-app"
wi_pool_provider_id_app = "wi-pool-provider-app"

*/




# (8) Create the triggers manually!



