locals {
  #cloud_build_service_account_email = "service-${var.project_number}@gcp-sa-cloudbuild.iam.gserviceaccount.com"
  cloud_build_service_account_email = "${var.project_number}@cloudbuild.gserviceaccount.com"
}
