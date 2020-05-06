module "cluster_1" {
  source                              = "./modules/cluster"
  name                                = var.name
  region                              = var.region
  node_subnet_range                   = var.node_subnet_range
  pod_subnet_range                    = var.pod_subnet_range
  service_subnet_range                = var.service_subnet_range
  nodepool_count                      = var.nodepool_count
  min_master_version                  = var.min_master_version
  machine_type                        = var.machine_type
  default_min_nodes_per_zone_per_pool = var.default_min_nodes_per_zone_per_pool
  default_max_nodes_per_zone_per_pool = var.default_max_nodes_per_zone_per_pool
  gcr_bucket_name                     = "eu.artifacts.${data.google_project.container-images.name}.appspot.com"
  initial_node_count                  = var.initial_node_count
  preemptible                         = var.preemptible
}

# Enable services in newly created GCP Project.
resource "google_project_service" "gcp-services" {
  count   = length(var.gcp_service_list)
  project = var.project_id
  service = var.gcp_service_list[count.index]
}
