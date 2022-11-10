resource "google_storage_bucket" "artifact_bucket" {
  name                        = var.artifact_bucket
  location                    = var.region
  project                     = var.project
  storage_class               = var.storage_class
  labels                      = var.labels
  uniform_bucket_level_access = true
}