resource "helm_release" "socksshop" {
  name       = "socksshop"
  chart      = "${path.module}/chart"
  keyring    = ""
  wait       = false

  set {
    name  = "ingress.hosts[0]"
    value = var.frontend_hostname
  }

  set {
    name  = "ingress.tls[0].secretName"
    value = "socksshop-tls"
  }

  set {
    name  = "ingress.tls[0].hosts[0]"
    value = var.frontend_hostname
  }

  set {
    name  = "ingress.annotations.kubernetes\\.io/ingress\\.class"
    value = "gce"
  }

  set {
    name  = "ingress.annotations.cert-manager\\.io/cluster-issuer"
    value = "letsencrypt-http01"
  }

  set_string {
    name  = "ingress.annotations.acme\\.cert-manager\\.io/http01-edit-in-place"
    value = "true"
  }

  set {
    name  = "ingress.annotations.kubernetes\\.io/ingress\\.global-static-ip-name"
    value = var.global_static_ip_name
  }
}