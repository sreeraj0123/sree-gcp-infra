/* No space around =
export TF_VAR_project_id="sree-gcp-dev"
export TF_VAR_project_number="49316739423"
export TF_VAR_region="us-central1"
echo $TF_VAR_project_id
echo $TF_VAR_region
*/



pre_api_list   = [
    "cloudresourcemanager.googleapis.com", # or use gcloud, cloud console?
    "secretmanager.googleapis.com", 
    "storage.googleapis.com",
]

bucket_name = "sree-tf-backend" # globally unique name
