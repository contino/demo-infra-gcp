data "google_client_config" "current" {
}

locals {
  required_apis = [
    "iam",
    "cloudfunctions",
    "cloudresourcemanager",
    "compute",
    "container",
    "cloudkms",
    "dns",
    "sqladmin",
    "containeranalysis",
  ]
}

resource "google_project_service" "api" {
  count              = length(local.required_apis)
  service            = "${local.required_apis[count.index]}.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_network" "vpc" {
  name                    = "${var.name}-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "vpc_regional_subnet" {
  name          = "${var.name}-${var.region}"
  network       = google_compute_network.vpc.name
  region        = var.region
  ip_cidr_range = var.node_ip_range

  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = var.pod_ip_range
  }

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = var.service_ip_range
  }
}

resource "google_container_cluster" "cluster" {
  provider = google-beta
  name     = var.name
  location = var.region

  network = "projects/${data.google_client_config.current.project}/global/networks/${google_compute_network.vpc.name}"

  subnetwork = "projects/${data.google_client_config.current.project}/regions/${var.region}/subnetworks/${google_compute_subnetwork.vpc_regional_subnet.name}"

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  min_master_version = var.min_master_version

  monitoring_service = "monitoring.googleapis.com/kubernetes"
  logging_service    = "logging.googleapis.com/kubernetes"

  initial_node_count       = 1
  remove_default_node_pool = true


  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "0.0.0.0/0"
      display_name = "demo-public"
    }
  }

  network_policy {
    enabled  = true
    provider = "CALICO"
  }

  pod_security_policy_config {
    enabled = false
  }


  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }

    username = ""
    password = ""
  }

  lifecycle {
    ignore_changes = [
      min_master_version,
      initial_node_count,
    ]
  }
}

resource "google_service_account" "cluster" {
  account_id   = var.name
  display_name = "Default service account for nodes of cluster ${google_container_cluster.cluster.name}"
  depends_on   = [google_project_service.api]
}

resource "google_project_iam_member" "gke_node_logwriter" {
  member = "serviceAccount:${google_service_account.cluster.email}"
  role   = "roles/logging.logWriter"
}

resource "google_project_iam_member" "gke_node_metricwriter" {
  member = "serviceAccount:${google_service_account.cluster.email}"
  role   = "roles/monitoring.metricWriter"
}

resource "google_project_iam_member" "gke_node_monitoringviewer" {
  member = "serviceAccount:${google_service_account.cluster.email}"
  role   = "roles/monitoring.viewer"
}

