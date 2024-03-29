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

# variable "image_0_tag" {
#   type        = string
#   description = "Docker image version"
#   default     = "2.5"
# }

# variable "image_1_tag" {
#   type        = string
#   description = "Docker image version"
#   default     = "0.1"
# }

# variable "environment" {
#   type        = string
#   description = "The project to deploy resources"
#   default = "dev"
#   validation {
#     condition     = var.environment == "dev" || var.environment == "prod"
#     error_message = "The environment string value must be 'dev' or 'prod'."
#   }
# }