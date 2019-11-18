provider "kubernetes" {
  token                  = data.google_client_config.current.access_token
  host                   = google_container_cluster.controller.endpoint
  cluster_ca_certificate = base64decode(google_container_cluster.controller.master_auth[0].cluster_ca_certificate)
  client_certificate     = base64decode(google_container_cluster.controller.master_auth[0].client_certificate)
  client_key             = base64decode(google_container_cluster.controller.master_auth[0].client_key)
}

resource "kubernetes_storage_class" "pd_ssd" {
  metadata {
    name = "pd-ssd"
  }

  storage_provisioner = "kubernetes.io/gce-pd"
  parameters = {
    type = "pd-ssd"
  }
}

resource "kubernetes_service_account" "tiller" {
  metadata {
    name      = "tiller"
    namespace = "kube-system"
  }
  secret {
    name = "${kubernetes_secret.tiller.metadata.0.name}"
  }

  automount_service_account_token = true
}

resource "kubernetes_secret" "tiller" {
  metadata {
    name      = "tiller"
    namespace = "kube-system"
  }
}

resource "kubernetes_cluster_role_binding" "tiller" {
  metadata {
    name = "tiller"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "tiller"
    namespace = "kube-system"
  }
}

// Left out due lack of DNS permissions

# resource "kubernetes_secret" "dns_admin" {
#   metadata {
#     name = "dns-admin-credentials"
#   }

#   data = {
#     "credentials.json" = base64decode(google_service_account_key.dns_admin.private_key)
#   }
# }