output "cluster_name" {
  value = module.cluster.cluster_name
}

output "cluster_endpoint" {
  value = module.cluster.cluster_endpoint
}

output "cluster_service_account_email" {
  value = module.cluster.service_account_email
}

output "cluster_cluster_ca_certificate" {
  value     = module.cluster.cluster_ca_certificate
  sensitive = true
}

output "cluster_subnet_name" {
  value = module.cluster.subnet_name
}

output "cluster_network_name" {
  value = module.cluster.network_name
}

output "cluster_static_ip" {
  value = google_compute_address.static.address
}
