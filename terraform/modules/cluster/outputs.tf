output "service_account_email" {
  value = google_service_account.cluster.email
}

output "subnet_name" {
  value = google_compute_subnetwork.vpc_regional_subnet.name
}

output "cluster_name" {
  value = google_container_cluster.cluster.name
}

output "cluster_master_version" {
  value = google_container_cluster.cluster.master_version
}

output "cluster_region" {
  value = google_container_cluster.cluster.region
}

output "cluster_endpoint" {
  value = google_container_cluster.cluster.endpoint
}

output "cluster_ca_certificate" {
  value = google_container_cluster.cluster.master_auth[0].cluster_ca_certificate
}

output "network_name" {
  value = google_compute_network.vpc.name
}

