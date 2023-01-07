# I used this for when I believed I needed to add all Service Accounts to each bucket
# This will create a cartesian product or "cross-join" of all possible combinations of buckets and Service Accounts

# locals {
#   bucket_s_accounts = flatten([
#     for bucket_client in var.looker_clients : [
#       for sa_client in var.looker_clients : {
#         bucket_client = bucket_client
#         sa_client     = sa_client
#       }
#     ]
#   ])
# }

resource "google_service_account" "sa-looker" {
  for_each     = toset(var.looker_clients)
  account_id   = "sa-looker-${each.value}"
  display_name = "sa-looker-${each.value}"
  project      = var.project
  description  = "service account for sa-looker-${each.value}"
}

# This will use the local cross-join map to create IAM bindings for all Service Accounts on all buckets
# I later found this isn't the use case, but I left it here for reference

# resource "google_storage_bucket_iam_member" "gcs-looker-bucket-owner" {
#   for_each = {
#     for entry in local.bucket_s_accounts : "${entry.bucket_client}.${entry.sa_client}" => entry
#   }
#   bucket     = "${each.value.bucket_client}-${var.environment}-${var.project}"
#   role       = "roles/storage.legacyBucketOwner"
#   member     = "serviceAccount:sa-looker-${each.value.sa_client}@${var.project}.iam.gserviceaccount.com"
#   depends_on = [google_service_account.sa-looker]
# }