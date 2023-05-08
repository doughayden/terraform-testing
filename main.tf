module "storage" {
  source                   = "./modules/storage"
  project                  = var.project
  region                   = local.region
  labels                   = local.labels
  artifact_bucket          = "${local.project}-${local.bucket_prefix}-artifact"
  secret_token_bucket_name = "secret-token-${module.secrets.test_secret_token_value}"
  environment              = var.environment
  looker_clients           = local.looker_clients
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
}

# Added to test for SR

module "service_accounts" {
  source         = "./modules/service_accounts"
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
}

module "big_query" {
  source  = "./modules/big_query"
  project = local.project
  region  = local.region
}

module "secrets" {
  source  = "./modules/secrets"
  project = local.project
}
