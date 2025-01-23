resource "google_sql_database_instance" "instance" {
  name             = "postgres-instance"
  region           = "us-central1"
  database_version = "POSTGRES_14"

  settings {
    tier = "db-custom-2-7680" #  tier = "db-perf-optimized-N-96"
    # edition = "ENTERPRISE_PLUS"
    /*
    backup_configuration {
      enabled    = true
      start_time = "20:55"
      location = "us-central1"
      backup_retention_settings {
        retained_backups = 365
        retention_unit   = "COUNT"
      }
    }
    ip_configuration {
      authorized_networks {
        name            = "Network Name"
        value           = "192.0.2.0/24"
        expiration_time = "3021-11-15T16:19:00.094Z"
      }
    }
    user_labels = {
      track        = "production"
      billing-code = 34802
    }
    password_validation_policy {
      min_length                  = 6
      reuse_interval              = 2
      complexity                  = "COMPLEXITY_DEFAULT"
      disallow_username_substring = true
      password_change_interval    = "30s"
      enable_password_policy      = true
    }
    */
  }
  deletion_protection = false
}

resource "google_sql_database" "database" {
  name     = "my-database"
  instance = google_sql_database_instance.instance.name
}

resource "random_password" "pwd" {
  length  = 16
  special = false
}

resource "google_sql_user" "user" {
  name     = "user"
  instance = google_sql_database_instance.instance.name
  password = random_password.pwd.result
}

resource "google_project_service_identity" "gcp_sa_cloud_sql" {
  provider = google-beta
  service  = "sqladmin.googleapis.com"
}

resource "google_kms_key_ring" "keyring" {
  provider = google-beta
  name     = "keyring-name"
  location = "us-central1"
}

resource "google_kms_crypto_key" "key" {
  provider = google-beta
  name     = "crypto-key-name"
  key_ring = google_kms_key_ring.keyring.id
  purpose  = "ENCRYPT_DECRYPT"
}

resource "google_kms_crypto_key_iam_binding" "crypto_key" {
  provider      = google-beta
  crypto_key_id = google_kms_crypto_key.key.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"

  members = [
    "serviceAccount:${google_project_service_identity.gcp_sa_cloud_sql.email}",
  ]
}

resource "google_sql_database_instance" "postgres_instance_with_cmek" {
  name                = "postgres-instance-cmek"
  provider            = google-beta
  region              = "us-central1"
  database_version    = "POSTGRES_14"
  encryption_key_name = google_kms_crypto_key.key.id
  settings {
    tier = "db-custom-2-7680"
  }
  deletion_protection = false
}

resource "google_sql_database_instance" "instance" {
  name             = "postgres-instance"
  region           = "us-central1"
  database_version = "POSTGRES_14"
  settings {
    database_flags {
      name  = "log_connections"
      value = "on"
    }
    database_flags {
      name  = "log_min_error_statement"
      value = "error"
    }
    tier = "db-custom-2-7680"
  }
  deletion_protection = false
}

resource "google_sql_database_instance" "postgres_instance_ha" {
  name             = "postgres-instance-ha"
  region           = "us-central1"
  database_version = "POSTGRES_14"
  settings {
    tier              = "db-custom-2-7680"
    availability_type = "REGIONAL"
    backup_configuration {
      enabled                        = true
      point_in_time_recovery_enabled = true
      start_time                     = "20:55"
    }
  }
  deletion_protection = false
}

resource "google_sql_user" "iam_user" {
  name     = "test-user@example.com"
  instance = google_sql_database_instance.default.name
  type     = "CLOUD_IAM_USER"
}

resource "google_service_account" "default" {
  account_id   = "cloud-sql-postgres-sa"
  display_name = "Cloud SQL for Postgres Service Account"
}

resource "google_sql_user" "iam_service_account_user" {
  name     = trimsuffix(google_service_account.default.email, ".gserviceaccount.com")
  instance = google_sql_database_instance.default.name
  type     = "CLOUD_IAM_SERVICE_ACCOUNT"
}

data "google_project" "project" {
}

resource "google_project_iam_binding" "cloud_sql_user" {
  project = data.google_project.project.project_id
  role    = "roles/cloudsql.instanceUser"
  members = [
    "user:test-user@example.com",
    "serviceAccount:${google_service_account.default.email}"
  ]
}

resource "google_project_iam_binding" "cloud_sql_client" {
  project = data.google_project.project.project_id
  role    = "roles/cloudsql.client"
  members = [
    "user:test-user@example.com",
    "serviceAccount:${google_service_account.default.email}"
  ]
}

resource "google_compute_network" "peering_network" {
  name                    = "private-network"
  auto_create_subnetworks = "false"
}

resource "google_compute_global_address" "private_ip_address" {
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.peering_network.id
}

resource "google_service_networking_connection" "default" {
  network                 = google_compute_network.peering_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "google_sql_database_instance" "default" {
  name             = "private-ip-sql-instance"
  region           = "us-central1"
  database_version = "POSTGRES_14"

  depends_on = [google_service_networking_connection.default]

  settings {
    tier = "db-custom-2-7680"
    ip_configuration {
      ipv4_enabled    = "false"
      private_network = google_compute_network.peering_network.id
    }
  }
  deletion_protection = false
}

resource "google_compute_network_peering_routes_config" "peering_routes" {
  peering              = google_service_networking_connection.default.peering
  network              = google_compute_network.peering_network.name
  import_custom_routes = true
  export_custom_routes = true
}

resource "google_sql_database_instance" "postgres_instance" {
  name             = "postgres-instance"
  region           = "asia-northeast1"
  database_version = "POSTGRES_14"
  settings {
    tier = "db-custom-2-7680"
    ip_configuration {
      ssl_mode = "TRUSTED_CLIENT_CERTIFICATE_REQUIRED"
    }
  }

  deletion_protection = false
}

resource "google_sql_ssl_cert" "postgres_client_cert" {
  common_name = "postgres_common_name"
  instance    = google_sql_database_instance.postgres_instance.name
}
