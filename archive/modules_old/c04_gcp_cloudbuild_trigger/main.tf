

/*
resource "google_cloudbuildv2_connection" "my_connection" { 
  provider_id = "github" # Example provider 
  location = var.location 
  repository_id = var.repository_id 
  secret_id = var.secret_id 
}

resource "google_cloudbuildv2_repository" "my_repository" { 
  connection_id = google_cloudbuildv2_connection.my_connection.id 
  location = var.location 
  repository { name = var.repository_name } 
}
*/

resource "google_cloudbuildv2_repository" "my_repository" {
  location = var.region
  name = var.repo_name_gcp
  parent_connection = var.connection_parent
  remote_uri = var.repo_uri_remote
}



resource "google_cloudbuild_trigger" "cloud_build_trigger" {
  name        = var.trigger_name
  description = "Trigger to build and deploy using Cloud Build"
  project     = var.project_id
  filename = var.cloudbuild_yaml_path
  service_account = var.service_account
  included_files = ["**"]
  ignored_files  = []
  disabled = false

  github {    
    #owner  = var.connection_parent
    #name   = var.repo_name_gcp
    owner = var.github_owner
    name = google_cloudbuildv2_repository.my_repository.repository.name

    push {
      branch = var.branch_pattern
    }
  }

  /*
  trigger_template {
    project_id = var.project_id
    repo_name  = var.repo_name_gcp
    branch_name = var.branch_pattern
    dir         = "." # Specify the working directory if needed
  }
  */

  substitutions = {
    _CUSTOM_VAR_1 = var.custom_variable_1
    _CUSTOM_VAR_2 = var.custom_variable_2
    _CUSTOM_VAR_3 = var.custom_variable_3
  }

  
}