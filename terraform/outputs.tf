output "cluster_1_name" {
  value = module.cluster.cluster_name
}

output "cluster_1_region" {
  value = module.cluster.cluster_region
}

output "cluster_1_endpoint" {
  value = module.cluster.cluster_endpoint
}

output "cluster_1_service_account_email" {
  value = module.cluster.service_account_email
}

output "cluster_1_cluster_ca_certificate" {
  value     = module.cluster.cluster_ca_certificate
  sensitive = true
}

output "cluster_1_subnet_name" {
  value = module.cluster.subnet_name
}

output "cluster_1_network_name" {
  value = module.cluster.network_name
}

