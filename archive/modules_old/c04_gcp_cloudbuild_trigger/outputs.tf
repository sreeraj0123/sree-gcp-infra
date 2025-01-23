output "cloud_build_trigger_id" {
  description = "ID of the created Cloud Build trigger"
  value       = google_cloudbuild_trigger.cloud_build_trigger.id
}