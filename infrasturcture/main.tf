

module "mysql_db" {
  source          = "../modules/mysql_db"
  project_id      = var.project_id
  region          = var.region
  instance_name   = var.instance_name
  database_version = "MYSQL_8_0"
  tier            = "db-n1-standard-1"
  disk_size       = 20
  ipv4_enabled    = true
  databases = [
    {
      name      = "example_db"
      charset   = "utf8"
      collation = "utf8_general_ci"
    }
  ]
  users = [
    {
      name     = "admin"
      password = "secure-password"
    }
  ]
}
