resource "google_sql_database_instance" "Sql_instance" {
  name             = var.instance_name
  database_version = var.database_version

  settings {
    tier = var.tier
  }

  root_password = var.root_password
}