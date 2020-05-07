locals {
  kubernetes = {
    host                   = "https://${module.cluster_1.cluster_endpoint}"
    config_context_cluster = module.cluster_1.cluster_name
    cluster_ca_certificate = base64decode(module.cluster_1.cluster_ca_certificate)
    token                  = data.google_client_config.current.access_token
  }
}

provider "google" {
  version = "~> 3.18.0"
  project = var.project_id
}

provider "google-beta" {
  version = "~> 3.18.0"
  project = var.project_id
}

provider "kubernetes" {
  version = "~> 1.11"
}
