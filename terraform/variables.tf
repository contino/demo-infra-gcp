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
