resource "google_compute_network" "this" {
  name                    = "${var.name_prefix}-vpc"
  project                 = var.project_id
  auto_create_subnetworks = false
  routing_mode            = var.routing_mode
}

resource "google_compute_subnetwork" "this" {
  name          = "${var.name_prefix}-subnet-${var.region}"
  project       = var.project_id
  region        = var.region
  network       = google_compute_network.this.id
  ip_cidr_range = var.subnet_cidr
}

resource "google_vpc_access_connector" "this" {
  count = var.enable_vpc_connector ? 1 : 0

  name          = "${var.name_prefix}-connector"
  project       = var.project_id
  region        = var.region
  network       = google_compute_network.this.name
  ip_cidr_range = var.connector_cidr

  depends_on = [google_compute_subnetwork.this]
}
