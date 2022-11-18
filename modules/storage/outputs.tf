output "gcs_buckets_out" {
  value = tomap({
    for k, bucket in google_storage_bucket.gcs_buckets : k => bucket.id
  })
}