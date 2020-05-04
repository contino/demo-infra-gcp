# should be one of [preemptible|nonpreemptible]
variable "default_min_nodes_per_zone_per_pool" {
  default = 1
}

variable "default_max_nodes_per_zone_per_pool" {
  default = 3
}

variable "initial_node_count" {
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
