locals {
  project = var.project
  region  = "us-central1"
  zone    = "us-central1-a"
  labels = {
    "environment"          = "${var.environment}"
    "managed-by-terraform" = "true"
    "state"                = "active"
  }
  name_prefix   = "terraform-testing"
  bucket_prefix = "terrafrom-testing-${var.environment}"
  looker_clients = [
    "v3-test-1",
    "v3-test-2"
  ]
}
