locals {
  name            = "demo-application"
  region          = "europe-west1"
}

module "cluster_1" {
  source                              = "./modules/cluster"
  name                                = local.name
  region                              = local.region
  node_subnet_range                   = "10.0.0.0/24"
  pod_subnet_range                    = "10.224.0.0/17"
  service_subnet_range                = "10.128.0.0/17"
  nodepool_count                      = 1
  min_master_version                  = "1.14.10-gke.24"
  machine_type                        = "n1-standard-1"
  default_min_nodes_per_zone_per_pool = var.default_min_nodes_per_zone_per_pool
  default_max_nodes_per_zone_per_pool = var.default_max_nodes_per_zone_per_pool
  gcr_bucket_name                     = "bucket"
  initial_node_count                  = var.initial_node_count
  preemptible                         = "true"
}

