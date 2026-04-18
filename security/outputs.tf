output "runtime_service_account_email" {
  description = "Email of the Cloud Run runtime service account."
  value       = google_service_account.cloud_run_runtime.email
}

output "runtime_service_account_id" {
  description = "Fully qualified SA resource name."
  value       = google_service_account.cloud_run_runtime.name
}
