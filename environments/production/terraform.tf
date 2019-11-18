terraform {
  backend "gcs" {
    bucket = "maartje-socks-tfstate"
    prefix = "clusters/production/"
  }
}
