variable "chart_version" {
  description = "Chart version"
  default     = "v0.11.0"
}

variable "repository" {
  description = "Repository to pull the chart from"
}


// Left out due lack of DNS permissions

# variable "dns_credentials_secret_name" {
#   description = "Name of the Kubernetes secret containing the Google DNS credentials"
# }

# variable "dns_project" {
#   description = "Name of the GCP poject for DNS"
# }

variable "lets_encrypt_email" {
  description = "Email for let's encrypt"
}

variable "k8s_cluster_endpoint" {
  description = "Kubernetes endpoint to apply CRDs"
}

variable "k8s_cluster_ca_certificate" {
  description = "Kubernetes CA cert to apply CRDs"
}

variable "k8s_cluster_access_token" {
  description = "Kubernetes access token to apply CRDs"
}
