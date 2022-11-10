# "test1" function resources

data "archive_file" "test1_zip" {
  type             = "zip"
  source_dir       = "${path.module}/test1"
  output_path      = "${path.module}/tmp/test1.zip"
  output_file_mode = "0666"
}

resource "google_storage_bucket_object" "test1_code" {
  name   = "test1-${substr(regex("(?:[a-zA-Z](?:[-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?)", data.archive_file.test1_zip.output_md5), 0, 7)}.zip"
  source = data.archive_file.test1_zip.output_path
  bucket = var.artifact_bucket
}

resource "google_cloudfunctions_function" "test1" {
  name        = "test1"
  description = "Cloud function test1"
  runtime     = "python39"
  labels      = var.labels
  region      = var.region
  project     = var.project

  available_memory_mb   = 256
  source_archive_bucket = var.artifact_bucket
  source_archive_object = google_storage_bucket_object.test1_code.name
  timeout               = 60
  entry_point           = "this_is_a_fake_function"
  trigger_http          = true
}

# "test2" function resources

data "archive_file" "test2_zip" {
  type             = "zip"
  source_dir       = "${path.module}/test2"
  output_path      = "${path.module}/tmp/test2.zip"
  output_file_mode = "0666"
}

resource "google_storage_bucket_object" "test2_code" {
  name   = "test2-${substr(regex("(?:[a-zA-Z](?:[-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?)", data.archive_file.test2_zip.output_md5), 0, 7)}.zip"
  source = data.archive_file.test2_zip.output_path
  bucket = var.artifact_bucket
}

resource "google_cloudfunctions_function" "test2" {
  name        = "test2"
  description = "Cloud function test2"
  runtime     = "python39"
  labels      = var.labels
  region      = var.region
  project     = var.project

  available_memory_mb   = 256
  source_archive_bucket = var.artifact_bucket
  source_archive_object = google_storage_bucket_object.test2_code.name
  timeout               = 60
  entry_point           = "not_a_real_function"
  trigger_http          = true
}