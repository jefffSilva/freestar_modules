locals {
  sa_id = coalesce(var.service_account_id, "${var.name_prefix}-cloud-run")
}

resource "google_service_account" "cloud_run_runtime" {
  account_id   = local.sa_id
  display_name = "${var.name_prefix} Cloud Run runtime"
  project      = var.project_id
}

resource "google_project_iam_member" "secret_accessor" {
  count = var.grant_secret_accessor_project ? 1 : 0

  project = var.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${google_service_account.cloud_run_runtime.email}"
}

resource "google_project_iam_member" "additional" {
  for_each = toset(var.additional_project_roles)

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.cloud_run_runtime.email}"
}
