module "storage" {
  source          = "./modules/storage"
  project         = var.project
  region          = local.region
  labels          = local.labels
  name_prefix     = local.name_prefix
  artifact_bucket = "${local.project}-${local.bucket_prefix}-artifact"
  environment     = var.environment
  looker_clients  = var.looker_clients
}

module "cloud_function" {
  source          = "./modules/cloud_function"
  project         = local.project
  region          = local.region
  labels          = local.labels
  name_prefix     = local.name_prefix
  artifact_bucket = "${local.project}-${local.bucket_prefix}-artifact"
  #depends_on      = [module.storage]
}

module "service-accounts" {
  source         = "./modules/service-accounts"
  project        = local.project
  region         = local.region
  labels         = local.labels
  environment    = var.environment
  looker_clients = var.looker_clients
}