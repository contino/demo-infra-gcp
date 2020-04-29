locals {
  name            = "demo-application"
  region          = "europe-west1"
  project_id      = "jagendra-atal-prakash-contino"

}

module "cluster_1" {
  source                              = "./modules/cluster"
  name                                = local.name
  region                              = local.region
  node_subnet_range                   = "10.0.0.0/24"
  pod_subnet_range                    = "10.224.0.0/17"
  service_subnet_range                = "10.128.0.0/17"
  nodepool_count                      = 1
  min_master_version                  = "1.14.10-gke.27"
  machine_type                        = "n1-standard-1"
  default_min_nodes_per_zone_per_pool = var.default_min_nodes_per_zone_per_pool
  default_max_nodes_per_zone_per_pool = var.default_max_nodes_per_zone_per_pool
  gcr_bucket_name                     = "bucket"
  initial_node_count                  = var.initial_node_count
  preemptible                         = "true"
}

resource "google_service_account" "service_account" {
  account_id   = "containerregistry"
  display_name = "Service Account for container registry"
  project      = local.project_id
}

resource "google_project_iam_member" "role-binding" {
  project = local.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.service_account.email}"
}

data "google_project" "container_images" {
  project_id = local.project_id
}

locals {
  gcr_bucket_name = "eu.artifacts.${data.google_project.container_images.name}.appspot.com"
}

resource "google_project_iam_custom_role" "container_registry_tenant" {
  project     = data.google_project.container_images.name
  role_id     = "ContainerRegistryTenant"
  title       = "Container Registry Tenant"
  description = "This role allows docker push to registry"

  permissions = [
    "resourcemanager.projects.get",
    "storage.buckets.get",
    "storage.objects.create",
    "storage.objects.delete",
    "storage.objects.get",
    "storage.objects.list",
    "storage.objects.update",
  ]
}

resource "google_project_service" "container_registry" {
  project            = data.google_project.container_images.name
  service            = "containerregistry.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "container_analysis" {
  project            = data.google_project.container_images.name
  service            = "containeranalysis.googleapis.com"
  disable_on_destroy = false
}