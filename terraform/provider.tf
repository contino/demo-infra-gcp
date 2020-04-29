locals {
  kubernetes = {
    host                   = "https://${module.cluster_1.cluster_endpoint}"
    config_context_cluster = module.cluster_1.cluster_name
    cluster_ca_certificate = base64decode(module.cluster_1.cluster_ca_certificate)
    token                  = data.google_client_config.current.access_token
  }
}

provider "google" {
  version = "~> 2.18.0"
  project = "jagendra-atal-prakash-contino"
}

provider "google-beta" {
  version = "~> 2.18.0"
  project = "jagendra-atal-prakash-contino"
}

provider "kubernetes" {
  alias                  = "cluster-k8s"
  host                   = local.kubernetes["host"]
  config_context_cluster = local.kubernetes["config_context_cluster"]
  cluster_ca_certificate = local.kubernetes["cluster_ca_certificate"]
  token                  = local.kubernetes["token"]
  config_path            = "/tmp/tf-kube-config"
}

