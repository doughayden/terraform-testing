/* --------------------------------------------------------------------------
 Remote .tfstate: in Google Cloud Storage (GCS)
-------------------------------------------------------------------------- */

terraform {
  required_version = ">=0.14"
  backend "gcs" {
    bucket = "doug-sandbox-tf-state"
    prefix = "terraform/state"
  }
}