resource "google_sql_database_instance" "default" {
  name             = var.instance_name
  project          = var.project_id
  region           = var.region
  database_version = var.database_version

  settings {
    tier              = var.tier
    disk_size         = var.disk_size
    disk_type         = var.disk_type
    availability_type = var.availability_type

    backup_configuration {
      enabled = var.backup_enabled
    }

    ip_configuration {
      ipv4_enabled    = var.ipv4_enabled
      private_network = var.private_network
      require_ssl     = var.require_ssl
    }
  }
}

resource "google_sql_database" "default" {
  count     = length(var.databases)
  name      = var.databases[count.index].name
  instance  = google_sql_database_instance.default.name
  project   = var.project_id
  charset   = var.databases[count.index].charset
  collation = var.databases[count.index].collation
}

resource "google_sql_user" "default" {
  count    = length(var.users)
  name     = var.users[count.index].name
  instance = google_sql_database_instance.default.name
  project  = var.project_id
  password = var.users[count.index].password
}
