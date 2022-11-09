#terraform {
#    required_providers {
#    google = {
#      version = "~> 4.21.0"
#    }
#  }
#  required_version = "~> 0.14.4"
#}

provider "google" {}

locals {
  project = "doug-hayden-eng-sandbox"
  region  = "us-central1"
}

resource "google_storage_bucket" "example_bucket" {
  name                        = "${local.project}-terraform-test-000"
  location                    = local.region
  project                     = local.project
  storage_class               = "STANDARD"
  labels                      = { "environment" = "test" }
  uniform_bucket_level_access = true
}

data "archive_file" "test_zip" {
  type             = "zip"
  source_dir       = "./test-code"
  output_path      = "./tmp/test.zip"
  output_file_mode = "0666"
}

resource "google_storage_bucket_object" "test_code" {
  name   = "test#${substr(regex("(?:[a-zA-Z](?:[-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?)", data.archive_file.test_zip.output_md5), 0, 7)}.zip"
  source = "./tmp/test.zip"
  bucket = google_storage_bucket.example_bucket.name
}

resource "google_cloudfunctions_function" "test" {
  name        = "test"
  description = "Cloud function test"
  runtime     = "python39"
  labels      = { "environment" = "test" }
  region      = local.region
  project     = local.project

  available_memory_mb   = 256
  source_archive_bucket = google_storage_bucket.example_bucket.name
  source_archive_object = google_storage_bucket_object.test_code.name
  timeout               = 60
  entry_point           = "this_is_a_fake_function"
  trigger_http          = true
}

data "archive_file" "test2_zip" {
  type             = "zip"
  source_dir       = "./test2-code"
  output_path      = "./tmp/test2.zip"
  output_file_mode = "0666"
}

resource "google_storage_bucket_object" "test2_code" {
  name   = "test2#${substr(regex("(?:[a-zA-Z](?:[-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?)", data.archive_file.test2_zip.output_md5), 0, 7)}.zip"
  source = "./tmp/test2.zip"
  bucket = google_storage_bucket.example_bucket.name
}

resource "google_cloudfunctions_function" "test2" {
  name        = "test2"
  description = "Cloud function test2"
  runtime     = "python39"
  labels      = { "environment" = "test" }
  region      = local.region
  project     = local.project

  available_memory_mb   = 256
  source_archive_bucket = google_storage_bucket.example_bucket.name
  source_archive_object = google_storage_bucket_object.test2_code.name
  timeout               = 60
  entry_point           = "not_a_real_function"
  trigger_http          = true
}