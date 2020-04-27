module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  project_id                 = "kubernetes-cp"
  name                       = "demo-application"
  region                     = "europe-west1"
  zones                      = ["europe-west1-b", "europe-west1-c", "europe-west1-d"]
  network                    = "vpc-01"
  subnetwork                 = "europe-west1-01"
  ip_range_pods              = "europe-west1-01-gke-01-pods"
  ip_range_services          = "europe-west1-01-gke-01-services"
  http_load_balancing        = false
  horizontal_pod_autoscaling = true
  network_policy             = true

  node_pools = [
    {
      name               = "default-node-pool"
      machine_type       = "n1-standard-2"
      min_count          = 1
      max_count          = 10
      local_ssd_count    = 0
      disk_size_gb       = 100
      disk_type          = "pd-standard"
      image_type         = "COS"
      auto_repair        = true
      auto_upgrade       = true
      service_account    = "circleci@kubernetes-cp.iam.gserviceaccount.com"
      preemptible        = true
      initial_node_count = 80
    },
  ]

  node_pools_oauth_scopes = {
    all = []

    default-node-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}