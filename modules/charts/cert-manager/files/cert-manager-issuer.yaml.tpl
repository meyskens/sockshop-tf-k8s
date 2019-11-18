apiVersion: cert-manager.io/v1alpha2
kind: ClusterIssuer
metadata:
  name: ${name}
  namespace: default
spec:
  acme:
    # The ACME server URL
    server: ${server}
    # Email address used for ACME registration
    email: ${email}
    # Name of a secret used to store the ACME account private key
    privateKeySecretRef:
      name: letsencrypt-private-key
    solvers:
    # An empty 'selector' means that this solver matches all domains
    - selector: {}
      http01:
        ingress:
          class: gce
