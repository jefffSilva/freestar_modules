locals {
  enable_https = length(var.ssl_domains) > 0
}

resource "google_compute_global_address" "lb" {
  project = var.project_id
  name    = "${var.name_prefix}-lb-ip"
}

resource "google_compute_region_network_endpoint_group" "cloud_run" {
  project               = var.project_id
  name                  = "${var.name_prefix}-cr-neg"
  region                = var.region
  network_endpoint_type = "SERVERLESS"

  cloud_run {
    service = var.cloud_run_service_name
  }
}

resource "google_compute_backend_service" "cloud_run" {
  project               = var.project_id
  name                  = "${var.name_prefix}-lb-backend"
  protocol              = "HTTP"
  load_balancing_scheme = "EXTERNAL_MANAGED"

  backend {
    group           = google_compute_region_network_endpoint_group.cloud_run.id
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_url_map" "main" {
  project         = var.project_id
  name            = "${var.name_prefix}-url-map"
  default_service = google_compute_backend_service.cloud_run.id
}

resource "google_compute_target_http_proxy" "http" {
  project = var.project_id
  name    = "${var.name_prefix}-http-proxy"
  url_map = google_compute_url_map.main.id
}

resource "google_compute_global_forwarding_rule" "http" {
  project               = var.project_id
  name                  = "${var.name_prefix}-http-fr"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  target                = google_compute_target_http_proxy.http.id
  port_range            = "80"
  ip_address            = google_compute_global_address.lb.address
}

resource "google_compute_managed_ssl_certificate" "lb" {
  count   = local.enable_https ? 1 : 0
  project = var.project_id
  name    = "${var.name_prefix}-lb-cert"

  managed {
    domains = var.ssl_domains
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_target_https_proxy" "https" {
  count            = local.enable_https ? 1 : 0
  project          = var.project_id
  name             = "${var.name_prefix}-https-proxy"
  url_map          = google_compute_url_map.main.id
  ssl_certificates = [google_compute_managed_ssl_certificate.lb[0].id]
}

resource "google_compute_global_forwarding_rule" "https" {
  count                 = local.enable_https ? 1 : 0
  project               = var.project_id
  name                  = "${var.name_prefix}-https-fr"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  target                = google_compute_target_https_proxy.https[0].id
  port_range            = "443"
  ip_address            = google_compute_global_address.lb.address
}

resource "google_cloud_run_v2_service_iam_member" "invoker" {
  count = var.allow_unauthenticated_invoker ? 1 : 0

  project  = var.project_id
  location = var.region
  name     = var.cloud_run_service_name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
