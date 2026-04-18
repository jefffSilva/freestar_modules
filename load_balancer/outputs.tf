output "load_balancer_ip" {
  description = "Global external IP for the load balancer (point DNS / curl here)."
  value       = google_compute_global_address.lb.address
}

output "http_url" {
  description = "HTTP URL using the LB IP (use your domain after DNS is configured)."
  value       = "http://${google_compute_global_address.lb.address}"
}

output "https_enabled" {
  description = "Whether HTTPS forwarding and a managed certificate were created."
  value       = length(var.ssl_domains) > 0
}

output "managed_ssl_certificate_name" {
  description = "Managed certificate resource name (empty if HTTPS disabled)."
  value       = try(google_compute_managed_ssl_certificate.lb[0].name, "")
}
