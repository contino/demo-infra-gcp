variable "name" {
}

variable "node_ip_range" {
}

variable "pod_ip_range" {
}

variable "service_ip_range" {
}

variable "region" {
}

variable "nodepool_count" {
}

variable "min_master_version" {
}

variable "preemptible" {
}

variable "default_min_nodes_per_zone_per_pool" {
  default = "1"
}

variable "default_max_nodes_per_zone_per_pool" {
  default = "3"
}

variable "initial_node_count" {
  default = "1"
}

variable "machine_type" {
}

variable "disk_type" {
  default = "pd-standard"
}

variable "disk_size_gb" {
  default = "100"
}

variable "node_pool_oauth_scopes" {
  description = "The oauth scope(s) to apply to the node pools"
  type        = list(string)
  default     = ["cloud-platform"]
}

variable "gcr_bucket_name" {
  description = "The bucket name for the Google Container Registry"
}

