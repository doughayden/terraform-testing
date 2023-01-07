module "storage" {
  source          = "./modules/storage"
  project         = var.project
  region          = local.region
  labels          = local.labels
  artifact_bucket = "${local.project}-${local.bucket_prefix}-artifact"
  environment     = var.environment
  looker_clients  = local.looker_clients
  # sa_looker_map   = module.service-accounts.sa_looker_out
  # gcs_buckets_map = module.storage.gcs_buckets_out
}

module "cloud_function" {
  source          = "./modules/cloud_function"
  project         = local.project
  region          = local.region
  labels          = local.labels
  name_prefix     = local.name_prefix
  artifact_bucket = "${local.project}-${local.bucket_prefix}-artifact"
  # depends_on      = [module.storage]
}

# Added to test for SR

module "service_accounts" {
  source         = "./modules/service-accounts"
  project        = local.project
  environment    = var.environment
  looker_clients = local.looker_clients
  # gcs_buckets_map     = module.storage.gcs_buckets_out # takes output from the srorage module to pass as a variable to the service-accounts module
  # sa_looker_email_map = module.service-accounts.sa_looker_email_out
  # depends_on = [module.storage]
}

module "cloud_run" {
  source  = "./modules/cloud_run"
  project = local.project
  region  = local.region
  # service_account_test = "cloud-run-svc@lmic-${var.environment}-datahub.iam.gserviceaccount.com"
}