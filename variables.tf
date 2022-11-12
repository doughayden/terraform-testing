variable "project" {
  type        = string
  description = "The deployment project"
  default     = ""
}

variable "environment" {
  type        = string
  description = "The deployment environment."
  validation {
    condition     = var.environment == "test" || var.environment == "dev" || var.environment == "prod"
    error_message = "The environment string value must be 'test', 'dev', or 'prod'."
  }
}