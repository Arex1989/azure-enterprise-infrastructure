variable "location" {
  description = "Azure region for the Terraform-managed environment."
  type        = string
  default     = "UK South"
}

variable "environment" {
  description = "Environment name."
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name used in resource naming."
  type        = string
  default     = "azure-enterprise"
}
