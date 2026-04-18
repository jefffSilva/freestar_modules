output "network_id" {
  description = "VPC network id."
  value       = google_compute_network.this.id
}

output "network_name" {
  description = "VPC network name."
  value       = google_compute_network.this.name
}

output "subnet_id" {
  description = "Regional subnet id."
  value       = google_compute_subnetwork.this.id
}

output "subnet_name" {
  description = "Regional subnet name."
  value       = google_compute_subnetwork.this.name
}

output "vpc_connector_id" {
  description = "Serverless VPC Access connector id (null if disabled)."
  value       = try(google_vpc_access_connector.this[0].id, null)
}

output "vpc_connector_name" {
  description = "Serverless VPC Access connector name (null if disabled)."
  value       = try(google_vpc_access_connector.this[0].name, null)
}
