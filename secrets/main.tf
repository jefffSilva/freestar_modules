locals {
  id = coalesce(var.secret_id, "${var.name_prefix}-sample-config")
}

resource "google_secret_manager_secret" "this" {
  project   = var.project_id
  secret_id = local.id

  replication {
    auto {}
  }

  labels = var.labels
}

resource "google_secret_manager_secret_version" "placeholder" {
  secret      = google_secret_manager_secret.this.id
  secret_data = base64encode("placeholder_value_for_terraform_apply")
}

resource "google_secret_manager_secret_iam_member" "runtime_accessor" {
  count = var.runtime_service_account_email == "" ? 0 : 1

  project   = var.project_id
  secret_id = google_secret_manager_secret.this.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${var.runtime_service_account_email}"
}
