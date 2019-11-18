// Left out due lack of DNS permissions

# ## DNS admin for cert-manager
# resource "google_service_account" "dns_admin" {
#   project      = var.project
#   account_id   = "dns-admin-${var.environment}"
#   display_name = "dns-admin-${var.environment}"
# }

# resource "google_service_account_key" "dns_admin" {
#   service_account_id = google_service_account.dns_admin.id
# }

# resource "google_project_iam_member" "dns_admin" {
#   project = var.project
#   role    = "roles/dns.admin"
#   member  = "serviceAccount:${google_service_account.dns_admin.email}"
# }