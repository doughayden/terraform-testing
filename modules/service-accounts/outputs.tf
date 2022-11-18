output "sa_looker_email_out" {
  value = tomap({
    for k, s_account in google_service_account.sa-looker : k => s_account.email
  })
}