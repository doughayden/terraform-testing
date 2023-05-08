# data "google_secret_manager_secret" "test_token" {
#   secret_id = "test-secret-token"
#   project   = var.project
# }

data "google_secret_manager_secret_version" "test_token_access" {
  secret  = "test-secret-token"
  project = var.project
}
