/* No space around =
gcloud config set project sree-gcp-dev-2
export TF_VAR_project_id="sree-gcp-dev-2"
export TF_VAR_project_number="526350941063"
export TF_VAR_region="us-central1"
echo $TF_VAR_project_id
echo $TF_VAR_project_number
echo $TF_VAR_region
#bucket_name = "should be unique"
*/



vpc_name = "sree-vpc"
subnet_name = "sree-subnet"
#subnet_region = "us-central1"
subnet_ip_range = "10.129.0.0/20"

artifact_repository_id = "sree-art"

secret_id_db_user = "db-user"
secret_id_db_password = "db-password"

sql_instance_name = "sree-sql"
sql_db_name = "sree-db"

cloud_run_sa_name = "sa-cloud-run"
cicd_sa_id_app = "sa-cicd-app"
cloud_run_sa_role_list = [
  "roles/secretmanager.secretAccessor",
  "roles/cloudsql.client",
]


