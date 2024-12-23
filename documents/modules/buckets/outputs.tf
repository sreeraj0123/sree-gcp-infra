output "instance_connection_name" {
  description = "Connection name for the Cloud SQL instance"
  value       = google_sql_database_instance.default.connection_name
}

output "public_ip_address" {
  description = "Public IP address of the instance"
  value       = google_sql_database_instance.default.public_ip_address
}
