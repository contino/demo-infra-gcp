module "cluster" {
  source                              = "./modules/cluster"
  name                                = var.name
  region                              = var.region
  node_ip_range                       = var.node_ip_range
  pod_ip_range                        = var.pod_ip_range
  service_ip_range                    = var.service_ip_range
  nodepool_count                      = var.nodepool_count
  min_master_version                  = var.min_master_version
  machine_type                        = var.machine_type
  default_min_nodes_per_zone_per_pool = var.default_min_nodes_per_zone_per_pool
  default_max_nodes_per_zone_per_pool = var.default_max_nodes_per_zone_per_pool
  initial_node_count                  = var.initial_node_count
  preemptible                         = var.preemptible
}

resource "google_compute_address" "static" {
  name     = "ipv4-demo-application"
  provider = google
  region   = var.region
}

resource "google_dns_managed_zone" "dns_zone" {
  name        = var.dns_zone_name
  dns_name    = var.dns_name
  description = "Demo DNS zone"
}

resource "google_dns_record_set" "primary" {
  name    = google_dns_managed_zone.dns_zone.dns_name
  project = var.project_id
  type    = "A"
  ttl     = "60"

  managed_zone = google_dns_managed_zone.dns_zone.name

  rrdatas = [google_compute_address.static.address]
}
