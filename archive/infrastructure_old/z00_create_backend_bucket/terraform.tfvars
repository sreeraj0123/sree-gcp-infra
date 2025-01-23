/* No space around =
export TF_VAR_project_id="cog-run-lab"
export TF_VAR_project_number="146758086101"
export TF_VAR_region="us-central1"
echo $TF_VAR_project_id
echo $TF_VAR_project_number
echo $TF_VAR_region

#bucket_name = "should be unique"
*/


api_list  = [
    "cloudresourcemanager.googleapis.com", # or use gcloud, cloud console?
    "secretmanager.googleapis.com", 
    "storage.googleapis.com",
]

bucket_name = "cog-run-tf-backend" # globally unique name
