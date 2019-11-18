provider "helm" {
  tiller_image = "gcr.io/kubernetes-helm/tiller:v2.15.0"

  service_account = kubernetes_service_account.tiller.metadata[0].name
  namespace       = kubernetes_cluster_role_binding.tiller.subject.0.namespace // creates implicit depends_on the CRB

  kubernetes {
    token                  = data.google_client_config.current.access_token
    host                   = google_container_cluster.controller.endpoint
    cluster_ca_certificate = base64decode(google_container_cluster.controller.master_auth[0].cluster_ca_certificate)
    client_certificate     = base64decode(google_container_cluster.controller.master_auth[0].client_certificate)
    client_key             = base64decode(google_container_cluster.controller.master_auth[0].client_key)
  }
}

data "helm_repository" "kubernetes-charts" {
  name = "kubernetes-charts"
  url  = "https://kubernetes-charts.storage.googleapis.com/"
}

data "helm_repository" "jetstack" {
  name = "jetstack"
  url  = "https://charts.jetstack.io"
}

module "cert_manager" {
  source             = "../../charts/cert-manager"
  repository         = data.helm_repository.jetstack.metadata[0].name
  lets_encrypt_email = var.lets_encrypt_email

  // Needed to apply the CRDs
  k8s_cluster_endpoint       = google_container_cluster.controller.endpoint
  k8s_cluster_ca_certificate = base64decode(google_container_cluster.controller.master_auth[0].cluster_ca_certificate)
  k8s_cluster_access_token   = data.google_client_config.current.access_token
}

module "socksshop" {
  source             = "../../charts/socksshop"
  frontend_hostname = "frontend.${var.dns_suffix}"
  global_static_ip_name = google_compute_global_address.frontend.name
}
