resource "google_storage_bucket" "artifact_bucket" {
  name                        = var.artifact_bucket
  location                    = var.region
  project                     = var.project
  storage_class               = var.storage_class
  labels                      = var.labels
  uniform_bucket_level_access = true
}

# Added to test for SR

resource "google_storage_bucket" "gcs_buckets" {
  for_each                    = toset(var.looker_clients)
  name                        = "${each.value}-${var.environment}-${var.project}"
  location                    = var.region
  force_destroy               = false
  project                     = var.project
  uniform_bucket_level_access = true
  labels                      = var.labels
  lifecycle_rule {
    condition {
      age = 90
    }
    action {
      type = "Delete"
    }
  }
}

# SR existing config, does not work unles IAM member and SA are both defined here.

# resource "google_storage_bucket_iam_member" "gcs-looker-bucket-owner" {
#   for_each = toset(var.looker_clients)
#   bucket = google_storage_bucket.gcs_buckets[each.value].id
#   role = "roles/storage.legacyBuckerOwner"
#   member = "serviceAccount:${google_service_account.sa-looker[each.value].email}"
# }

# resource "google_service_account" "sa-looker" {
#   for_each = toset(var.looker_clients)
#   account_id = "sa-looker-${each.value}"
#   display_name = "sa-looker-${each.value}"
#   project = var.project
#   description = "service account for sa-looker-${each.value}"
# }