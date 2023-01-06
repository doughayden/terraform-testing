# variable "service_account_datafetcher" {
#   type        = string
#   description = "datafetcher cloudrun Service Account"
# }

variable "project" {
  type        = string
  description = "GCP Project"
  default     = ""
}

variable "region" {
  type        = string
  description = "Google Cloud Platform Region Name"
  default     = ""
}

# variable "environment" {
#   type        = string
#   description = "The project where the data lake resources will be deployed"
#   default = "dev"
#   validation {
#     condition     = var.environment == "dev" || var.environment == "prod"
#     error_message = "The environment string value must be 'dev' or 'prod'."
#   }
# }