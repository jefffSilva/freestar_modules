variable "project_id" {
  description = "GCP project ID."
  type        = string
}

variable "name_prefix" {
  description = "Prefix for Secret Manager secret id."
  type        = string
  default     = "freestar"
}

variable "secret_id" {
  description = "Secret id (omit to use name_prefix-sample-config)."
  type        = string
  default     = null
}

variable "labels" {
  description = "Labels applied to the secret."
  type        = map(string)
  default     = {}
}

variable "runtime_service_account_email" {
  description = "Grant this identity secretAccessor on the created secret."
  type        = string
  default     = ""
}
