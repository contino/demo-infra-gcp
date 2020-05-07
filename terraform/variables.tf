variable "default_min_nodes_per_zone_per_pool" {
  default = 1
}

variable "default_max_nodes_per_zone_per_pool" {
  default = 3
}

variable "initial_node_count" {
  default = 1
}

variable "nodepool_count" {
  default = 1
}

variable "project_id" {
  description = "GCP Project ID."
  type        = string
}

variable "region" {
  description = "Google Cloud region"
  type        = string
  default     = "europe-west1"
}

variable "name" {
  description = "Cluster name"
  type        = string
  default     = "demo-application"
}

variable "preemptible" {
  default = true
}

variable "min_master_version" {
  type    = string
  default = "1.14.10-gke.27"
}

variable "machine_type" {
  description = "Machine type"
  type        = string
  default     = "n1-standard-1"
}

variable "node_ip_range" {
  description = "Node IP range"
  type        = string
  default     = "10.5.0.0/20"
}
variable "pod_ip_range" {
  description = "Pod IP range"
  type        = string
  default     = "10.0.0.0/14"
}

variable "service_ip_range" {
  description = "Service IP range"
  type        = string
  default     = "10.4.0.0/19"
}
