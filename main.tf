module "storage" {
  source      = "./modules/storage"
  project     = local.project
  region      = local.region
  labels      = local.labels
  name_prefix = local.name_prefix
}

module "cloud_function" {
  source          = "./modules/cloud_function"
  project         = local.project
  region          = local.region
  labels          = local.labels
  name_prefix     = local.name_prefix
  artifact_bucket = "${local.bucket_prefix}-artifact"
}
