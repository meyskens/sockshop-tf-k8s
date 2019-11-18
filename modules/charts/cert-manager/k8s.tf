resource "null_resource" "cert_manager_crd" {
  // Create needed CRDs here since they are not included in the helm chart
  // Create needed CRDs here since they are not included in the helm chart
  provisioner "local-exec" {
    when    = create
    command = "${path.module}/../../local-exec/kubectl-wrapper.sh https://${var.k8s_cluster_endpoint} \"${var.k8s_cluster_ca_certificate}\" \"${var.k8s_cluster_access_token}\" create --validate=false -f ${path.module}/files/cert-manager-crd.yaml"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "${path.module}/../../local-exec/kubectl-wrapper.sh https://${var.k8s_cluster_endpoint} \"${var.k8s_cluster_ca_certificate}\" \"${var.k8s_cluster_access_token}\" delete -f ${path.module}/files/cert-manager-crd.yaml"
  }
}

data "template_file" "cert_manager_cluster_issuer" {
  template = file("${path.module}/files/cert-manager-issuer.yaml.tpl")

  vars = {
    name   = "letsencrypt-http01"
    email  = var.lets_encrypt_email
    server = "https://acme-v02.api.letsencrypt.org/directory" // TODO: make useful variable
    // project     = var.dns_project // Left out due lack of DNS permissions
    // secret_name = var.dns_credentials_secret_name // Left out due lack of DNS permissions
  }
}

resource "null_resource" "cert_manager_cluster_issuer" {
  // Create the custom resource for cert-manager to use Let's Encrypt cluster wide
  // Create the custom resource for cert-manager to use Let's Encrypt cluster wide
  provisioner "local-exec" {
    when    = create
    command = "printf -- \"${data.template_file.cert_manager_cluster_issuer.rendered}\" | ${path.module}/../../local-exec/kubectl-wrapper.sh https://${var.k8s_cluster_endpoint} \"${var.k8s_cluster_ca_certificate}\" \"${var.k8s_cluster_access_token}\" create -f -"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "printf -- \"${data.template_file.cert_manager_cluster_issuer.rendered}\" | ${path.module}/../../local-exec/kubectl-wrapper.sh https://${var.k8s_cluster_endpoint} \"${var.k8s_cluster_ca_certificate}\" \"${var.k8s_cluster_access_token}\" delete -f -"
  }

  depends_on = [helm_release.cert_manager]
}
