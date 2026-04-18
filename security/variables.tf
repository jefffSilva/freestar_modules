variable "project_id" {
  description = "GCP project ID."
  type        = string
}

variable "name_prefix" {
  description = "Prefix for the Cloud Run runtime service account."
  type        = string
  default     = "freestar"
}

variable "service_account_id" {
  description = "Account ID (short name) for the runtime service account."
  type        = string
  default     = null
}

variable "grant_secret_accessor_project" {
  description = "If true, grants roles/secretmanager.secretAccessor at project scope. Prefer per-secret IAM from the secrets module for least privilege."
  type        = bool
  default     = false
}

variable "additional_project_roles" {
  description = "Extra project-level roles for the runtime SA (e.g. Artifact Registry reader)."
  type        = list(string)
  default = [
    "roles/artifactregistry.reader",
  ]
}
