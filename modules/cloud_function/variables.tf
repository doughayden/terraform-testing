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
  description = "List of labels."
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