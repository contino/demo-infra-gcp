output "cluster_1_name" {
  value = module.cluster_1.cluster_name
}

output "cluster_1_region" {
  value = module.cluster_1.cluster_region
}

output "cluster_1_endpoint" {
  value = module.cluster_1.cluster_endpoint
}

output "cluster_1_service_account_email" {
  value = module.cluster_1.service_account_email
}

output "cluster_1_cluster_ca_certificate" {
  value     = module.cluster_1.cluster_ca_certificate
  sensitive = true
}

output "cluster_1_subnet_name" {
  value = module.cluster_1.subnet_name
}

output "cluster_1_network_name" {
  value = module.cluster_1.network_name
}
output "gcr_service_account" {
  value = google_service_account.container-registry-user.email
}
