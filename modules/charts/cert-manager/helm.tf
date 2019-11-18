resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = var.repository
  chart      = "cert-manager"
  version    = var.chart_version
  keyring    = ""

  depends_on = [null_resource.cert_manager_crd]

  // Support for kube-lego annotations
  set {
    name  = "ingressShim.defaultIssuerName"
    value = "letsencrypt-http01"
  }

  // Support for kube-lego annotations
  set {
    name  = "ingressShim.defaultIssuerKind"
    value = "ClusterIssuer"
  }

  // Left out due lack of DNS permissions

  # // We need to set the default challenge type to dns01 or it will be set to http01
  # set {
  #   name  = "ingressShim.defaultACMEChallengeType"
  #   value = "dns01"
  # }

  # // Default challenge provider must be configured for dns01 challenge type
  # set {
  #   name  = "ingressShim.defaultACMEDNS01ChallengeProvider"
  #   value = "clouddns"
  # }
}

