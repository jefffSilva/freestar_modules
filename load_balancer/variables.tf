variable "project_id" {
  description = "GCP project ID."
  type        = string
}

variable "region" {
  description = "Cloud Run region (must match the service and the serverless NEG)."
  type        = string
}

variable "name_prefix" {
  description = "Prefix for LB resource names."
  type        = string
  default     = "freestar"
}

variable "cloud_run_service_name" {
  description = "Existing Cloud Run (v2) service name to attach behind the load balancer."
  type        = string
}

variable "allow_unauthenticated_invoker" {
  description = "Grant roles/run.invoker to allUsers so the external LB can invoke the service (typical for public HTTP(S) behind LB)."
  type        = bool
  default     = true
}

variable "ssl_domains" {
  description = "If non-empty, provisions a Google-managed cert and an HTTPS forwarding rule for these domains (DNS must point at the LB IP)."
  type        = list(string)
  default     = []
}
