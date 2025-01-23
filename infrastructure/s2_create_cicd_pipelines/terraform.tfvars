/*
things to check
1) globally unique names
- Cloud Storage Bucket Name:
- Cloud Run Service Name (when using custom domain)
- Artifact Registry Name (when accessed globally)
- public IP addresses
- Cloud DNS Zone Names
- Managed SSL Certificate Domains

*/


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


api_list  = [
    "cloudresourcemanager.googleapis.com",
    "secretmanager.googleapis.com", 
    "storage.googleapis.com",
    "cloudbuild.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "compute.googleapis.com",
    "sqladmin.googleapis.com"
]


secret_id_github = "github-token"
#secret_data_github = "github-token-value"
secret_id_db_user = "db-user"
secret_data_db_user = "db-user"
secret_id_db_password = "db-password"
#secret_data_db_password = "db-password"

connection_name_github = "github-connection"
app_installation_id_github = "55957239" 
github_account = "Mon8Cats"

cicd_sa_id_infra = "sa-cicd-infra"
cicd_log_bucket_infra = "spn-run-infra-logs" # infra: cloudbuild.yaml
github_repo_infra = "cog-run-infra"
repo_name_gcp_infra = "cog-run-infra"

cicd_sa_role_list_infra = [
  "roles/cloudbuild.builds.editor",
  "roles/storage.admin", 
  "roles/storage.objectViewer",  #"roles/storage.objectAdmin",
  "roles/secretmanager.secretAccessor",
  "roles/iam.serviceAccountUser",
  "roles/iam.serviceAccountAdmin", # Add this role
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


cicd_sa_id_app= "sa-cicd-app"
cicd_log_bucket_app = "spn-run-app-logs" # app: cloudbuild.yaml
github_repo_app = "cog-run-app"
repo_name_gcp_app = "cog-run-app"

cicd_sa_role_list_app = [
  "roles/cloudbuild.builds.editor",
  "roles/storage.admin",
  "roles/storage.objectViewer",  #"roles/storage.objectAdmin",
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
  "roles/compute.securityAdmin",
  "roles/serviceusage.serviceUsageAdmin",
  "roles/run.admin"
  
]





#