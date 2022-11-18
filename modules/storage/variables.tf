variable "project" {
  type        = string
  description = "The project where resources will be deployed"
  default     = ""
}

variable "region" {
  type        = string
  description = "Google Cloud Platform Region Name."
  default     = ""
}

variable "labels" {
  type        = map(string)
  description = "Map of labels."
  default     = {}
}

variable "artifact_bucket" {
  type        = string
  description = "Google Cloud Storage artifact bucket Name."
  default     = ""
}

variable "storage_class" {
  type        = string
  description = "Google Cloud Storage class."
  default     = "STANDARD"
}

# Added vars below to test for SR

variable "looker_clients" {
  type        = list(string)
  description = "new clients for project"
}

variable "environment" {
  type        = string
  description = "The deployment environment."
}

# variable "gcs_buckets_map" {
#   type = map(string)
#   description = "List of GCS buckets."
# }

# variable "sa_looker_map" {
#   type = map(string)
#   description = "Map of Looker Service Accounts."
# }