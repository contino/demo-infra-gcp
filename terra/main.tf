module "cluster_1" {
  source                              = "./modules/cluster"
  name                                = var.name
  region                              = var.region
  node_subnet_range                   = "10.0.0.0/24"
  pod_subnet_range                    = "10.224.0.0/17"
  service_subnet_range                = "10.128.0.0/17"
  nodepool_count                      = 1
  min_master_version                  = "1.14.10-gke.27"
  machine_type                        = "n1-standard-1"
  default_min_nodes_per_zone_per_pool = var.default_min_nodes_per_zone_per_pool
  default_max_nodes_per_zone_per_pool = var.default_max_nodes_per_zone_per_pool
  gcr_bucket_name                     = "eu.artifacts.${data.google_project.container_images.name}.appspot.com"
  initial_node_count                  = var.initial_node_count
  preemptible                         = "true"
}

resource "google_service_account" "service_account" {
  account_id   = "containerregistry"
  display_name = "Service Account for container registry"
  project      = var.project_id
}

resource "google_project_iam_member" "role-binding" {
  project = var.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.service_account.email}"
}

resource "google_container_registry" "registry" {
  project  = var.project_id
  location = "EU"
}

data "google_project" "container_images" {
  project_id = var.project_id
}

locals {
  gcr_bucket_name = "eu.artifacts.${data.google_project.container_images.name}.appspot.com"
}

# Enable services in newly created GCP Project.
resource "google_project_service" "gcp_services" {
  count   = length(var.gcp_service_list)
  project = var.project_id
  service = var.gcp_service_list[count.index]

  disable_dependent_services = true
}

resource "google_service_account_key" "containerregistry" {
  service_account_id = google_service_account.service_account.name
}

resource "kubernetes_secret" "containerregistry" {
  provider = kubernetes.cluster-k8s

  metadata {
    name = "gcr-json-key"
    namespace = "default"
  }

  data = {
    ".dockerconfigjson" = "${base64decode(google_service_account_key.containerregistry.private_key)}"
  }

  type = "kubernetes.io/dockerconfigjson"
}
