output "secret_id" {
  description = "Secret Manager secret id."
  value       = google_secret_manager_secret.this.secret_id
}

output "secret_name" {
  description = "Full resource name of the secret."
  value       = google_secret_manager_secret.this.name
}
