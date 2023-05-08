/* --------------------------------------------------------------------------
 Remote .tfstate: in Google Cloud Storage (GCS)
-------------------------------------------------------------------------- */

terraform {
  required_version = ">=0.14"
  backend "gcs" {
    bucket = "doug-sandbox-tf-state"
    prefix = "terraform/state"
  }
  required_providers {
    google = {
      version = ">= 4.51.0"
      source  = "hashicorp/google"
    }
    archive = {

    }
  }
}
