// commented out due lack of DNS permissions

# resource "google_dns_managed_zone" "dns_zone" {
#   name        = "${var.environment}-domain-zone"
#   dns_name    = "${var.dns_suffix}."
#   description = "DNS zone for ${var.dns_suffix}"
#   project      = var.project
# }

# resource "google_dns_record_set" "frontend" {
#   name = "frontend.${var.dns_suffix}."
#   type = "A"
#   ttl  = 300

#   managed_zone = google_dns_managed_zone.dns_zone.name
#   rrdatas      = [google_compute_global_address.frontend.address]
#   project      = var.project
# }