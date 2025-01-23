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
    "cloudresourcemanager.googleapis.com", # enable this first
    "secretmanager.googleapis.com", 
    "storage.googleapis.com",
]

bucket_name_unique = "sree-gcp-dev-tf-backend" # globally unique name
