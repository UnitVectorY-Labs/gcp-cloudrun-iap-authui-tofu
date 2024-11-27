variable "name" {
  description = "The name of the application (used for Cloud Run & Pub/Sub)"
  type        = string

  validation {
    condition     = can(regex("^[a-z](?:[-a-z0-9]{1,24}[a-z0-9])$", var.name))
    error_message = "The name must start with a lowercase letter and can contain lowercase letters, numbers, and hyphens. It must be between 2 and 24 characters long."
  }
}

variable "project_id" {
  description = "The GCP project id"
  type        = string
  validation {
    condition     = can(regex("^[a-z]([-a-z0-9]{0,61}[a-z0-9])?$", var.project_id))
    error_message = "The project_id is a GCP project name which starts with a lowercase letter, is 1 to 63 characters long, contains only lowercase letters, digits, and hyphens, and does not end with a hyphen."
  }
}

variable "region" {
  description = "The GCP region to deploy resources to"
  type        = string
}

variable "display_name" {
  description = "The display name of the tenant"
  type        = string
  default     = "IaP AuthUI"
}

variable "icon_url" {
  description = "The URL of the icon for the tenant"
  type        = string
  default     = ""
}

variable "logo_url" {
  description = "The URL of the logo for the tenant"
  type        = string
  default     = ""
}

variable "tos_url" {
  description = "The URL of the terms of service for the tenant"
  type        = string
  default     = ""
}

variable "privacy_policy_url" {
  description = "The URL of the privacy policy for the tenant"
  type        = string
  default     = ""
}

variable "iap_config" {
  description = "Map of API keys to their respective IAP configurations."
  type = map(object({
    tenants = map(object({
      sign_in_options = list(object({
        provider = string
      }))
    }))
  }))
}