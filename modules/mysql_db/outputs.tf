output "instance_name" {
  description = "The name of the SQL instance."
  value       = google_sql_database_instance.default.name
}

output "instance_connection_name" {
  description = "The connection name of the SQL instance."
  value       = google_sql_database_instance.default.connection_name
}
