module "cluster" {
  source             = "../../modules/clusters/socksshop"
  name               = "socks"
  environment        = "production"
  project            = "interview-maartje-socks"
  zone               = "europe-west1"
  dns_suffix         = "socks.maartje.dev"
  lets_encrypt_email = "maartje+socksshop@eyskens.me"
}
