resource "google_bigquery_dataset" "cc_test_dataset" {
  dataset_id    = "inference_data"
  friendly_name = "test to validate tf syntax"
  description   = "This is a test description"
  project       = var.project
  location      = "us-east1"

}

resource "google_bigquery_table" "cc_analytics" {
  dataset_id          = google_bigquery_dataset.cc_test_dataset.dataset_id
  table_id            = "cc_analytics"
  project             = var.project
  deletion_protection = false
  schema              = file("${path.module}/bq_schema/cc_analytics.json")
}

resource "google_bigquery_table" "cc_inference" {
  dataset_id          = google_bigquery_dataset.cc_test_dataset.dataset_id
  table_id            = "cc_inference"
  project             = var.project
  deletion_protection = false
  schema              = file("${path.module}/bq_schema/cc_inference.json")
}

resource "google_bigquery_table" "demo_inference" {
  dataset_id          = google_bigquery_dataset.cc_test_dataset.dataset_id
  table_id            = "demo_inference"
  project             = var.project
  deletion_protection = false
  schema              = file("${path.module}/bq_schema/demo_inference.json")
}

resource "google_bigquery_table" "device_info" {
  dataset_id          = google_bigquery_dataset.cc_test_dataset.dataset_id
  table_id            = "device_info"
  project             = var.project
  deletion_protection = false
  schema              = file("${path.module}/bq_schema/device_info.json")
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_table#schema:
# "...As a workaround, we recommend using the schema as returned by the API."
# Translation: leave out 'description' and 'fileds' if they are 'null' and '[]', respectively.
# You can see this calling bq show --schema=true {dataset}.{table} the schema will not return
# the null or empty values. Coppying schema as json from the console does yeild the empty result.  
# tf reads and interprests that as a change to the schema on plan or apply and wants to destroy the table.

# https://stackoverflow.com/questions/70425085/terraform-bigquery-table-schema-in-a-separate-json-file?rq=1

# Collapse table schema into a single json and use for each to pull out table names and indiv schema:
# https://stackoverflow.com/questions/66884998/terraform-bigquery-create-tables-replace-table-instead-of-edit
