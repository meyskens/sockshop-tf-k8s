variable "name" {
  description = "The name of the cluster, unique within the project and zone"
}

variable "project" {
  description = "GCP project"
}

variable "environment" {
  description = "Environment to deploy"
}

variable "zone" {
  description = "The zone that the master and nodes should be created in"
}

variable "worker_node_count" {
  description = "The number of nodes to create in this cluster with label srcd.host/type=worker"
  default     = 1
}

variable "node_version" {
  description = "The Kubernetes version on the nodes"
  default     = "1.14.8-gke.12"
}

variable "worker_machine_type" {
  description = "The name of a Google Compute Engine machine type for Worker nodes"
  default     = "n1-standard-4"
}

variable "worker_image_type" {
  description = "The image type to use for Worker nodes"
  default     = "COS"
}

variable "worker_disk_size_gb" {
  description = "Size of the disk attached for Worker nodes, specified in GB"
  default     = 100
}

variable "dns_suffix" {
  default = "DNS suffix to use to start public services under (eg. socks.maartje.dev)"
}

variable "lets_encrypt_email" {
  description = "Email for let's encrypt"
}
