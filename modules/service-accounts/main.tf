locals {
  bucket_s_accounts = flatten([
    for bucket in values(var.gcs_buckets_map) : [
      for email in values(var.sa_looker_email_map) : {
        bucket = bucket
        email  = email
      }
    ]
  ])
}

resource "google_service_account" "sa-looker" {
  for_each     = toset(var.looker_clients)
  account_id   = "sa-looker-${each.value}"
  display_name = "sa-looker-${each.value}"
  project      = var.project
  description  = "service account for sa-looker-${each.value}"
}

resource "google_storage_bucket_iam_member" "gcs-looker-bucket-owner" {
  for_each = {
    for entry in local.bucket_s_accounts : "${entry.bucket}.${entry.email}" => entry
  }
  bucket = each.value.bucket
  role   = "roles/storage.legacyBucketOwner"
  member = "serviceAccount:${each.value.email}"
}

# This also works

# resource "google_storage_bucket_iam_binding" "gcs-looker-bucket-owner" {
#   for_each = { for entry in local.bucket_s_accounts : "${entry.bucket}.${entry.email}" => entry }
#   bucket   = each.value.bucket
#   role     = "roles/storage.legacyBucketOwner"
#   members = [
#     "serviceAccount:${each.value.email}",
#   ]
# }