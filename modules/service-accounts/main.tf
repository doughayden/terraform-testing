# resource "google_service_account" "sa-looker" {
#   for_each = toset(var.looker_clients)
#   account_id = "sa-looker-${each.value}"
#   display_name = "sa-looker-${each.value}"
#   project = var.project
#   description = "service account for sa-looker-${each.value}"
# }