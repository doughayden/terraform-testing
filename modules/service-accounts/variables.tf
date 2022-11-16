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

variable "zone" {
  type        = string
  description = "Google Cloud Platform Zone Name."
  default     = ""
}

variable "labels" {
  type        = map(string)
  description = "Map of labels."
  default     = {}
}

variable "name_prefix" {
  type        = string
  description = "Name prefix."
  default     = ""
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