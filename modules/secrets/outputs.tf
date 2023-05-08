output "test_secret_token_value" {
  value     = data.google_secret_manager_secret_version.test_token_access.secret_data
  sensitive = true
}
