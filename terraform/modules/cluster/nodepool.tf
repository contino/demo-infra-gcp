resource "random_string" "nodepool_name" {
  count   = var.nodepool_count
  length  = 5
  special = false
  upper   = false

  keepers = {
    index        = count.index
    region       = var.region
    cluster      = google_container_cluster.cluster.name
    machine_type = var.machine_type
    oauth_scopes = join(",", var.node_pool_oauth_scopes)
    preemptible  = var.preemptible
  }
}

resource "google_container_node_pool" "nodepool" {
  provider = google-beta
  count    = var.nodepool_count
  name     = "nodepool-${random_string.nodepool_name[count.index].result}"
  location = random_string.nodepool_name.*.keepers.region[count.index]
  cluster  = random_string.nodepool_name.*.keepers.cluster[count.index]

  initial_node_count = var.initial_node_count
  version            = google_container_cluster.cluster.master_version

  node_config {
    machine_type    = random_string.nodepool_name.*.keepers.machine_type[count.index]
    service_account = google_service_account.cluster.email
    preemptible     = var.preemptible
    oauth_scopes    = var.node_pool_oauth_scopes

    labels = {
      preemptible = var.preemptible
    }

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }

  autoscaling {
    min_node_count = var.default_min_nodes_per_zone_per_pool
    max_node_count = var.default_max_nodes_per_zone_per_pool
  }

  management {
    auto_repair  = true
    auto_upgrade = false
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [version]
  }
}
