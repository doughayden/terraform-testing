variable "project" {
  type        = string
  description = "The project where resources will be deployed"
  default     = ""
}

variable "environment" {
  type        = string
  description = "The deployment environment."
}

variable "looker_clients" {
  type        = list(string)
  description = "new clients for project"
}

# variable "gcs_buckets_map" {
#   type        = map(string)
#   description = "List of GCS buckets."
# }

# variable "sa_looker_email_map" {
#   type        = map(string)
#   description = "List of Service Account emails for Looker buckets."
# }