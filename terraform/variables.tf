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
variable "gcp_service_list" {
  description = "List of GCP service to be enabled for a project."
  type        = list
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

variable "node_subnet_range" {
  description = "Node Subnet range"
  type        = string
  default     = "10.0.0.0/24"
}
variable "pod_subnet_range" {
  description = "Pod Subnet range"
  type        = string
  default     = "10.224.0.0/17"
}

variable "service_subnet_range" {
  description = "Service Subnet range"
  type        = string
  default     = "10.128.0.0/17"
}
