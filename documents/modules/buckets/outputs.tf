output "bucket_name" {
  value       = google_storage_bucket.bucket.name
  description = "The name of the GCP bucket."
}

output "bucket_url" {
  value       = google_storage_bucket.bucket.url
  description = "The URL of the GCP bucket."
}
