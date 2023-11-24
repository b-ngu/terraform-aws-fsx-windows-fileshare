# Tagging & Resource Context
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "contact" {
  type        = string
  description = "(Required) The contact for this resource."
}

variable "environment" {
  type        = string
  description = "(Required) The environment where this resource will live."
}

variable "team" {
  type        = string
  description = "(Required) The team responsible for this resource."
}

variable "purpose" {
  type        = string
  description = "(Required) The purpose for this resource."
}

# FSX Windows File Share Settings
variable "automatic_backup_retention_days" {
  type        = number
  default     = 7
  description = "The number of days to retain automatic backups. Minimum of 0 and maximum of 90"
}

variable "deployment_type" {
  type        = string
  default     = "SINGLE_AZ_1"
  description = "Specifies the file system deployment type, valid values are MULTI_AZ_1, SINGLE_AZ_1 and SINGLE_AZ_2"
  validation {
    condition     = contains(["MULTI_AZ_1", "SINGLE_AZ_1", "SINGLE_AZ_2"], var.deployment_type)
    error_message = "The storage type value must be MULTI_AZ_1, SINGLE_AZ_1, or SINGLE_AZ_2"
  }
}

variable "fsx_kms_key" {
  type        = string
  default     = "aws/fsx"
  description = "ARN for the KMS Key to encrypt the file system at rest"
}

variable "storage_capacity" {
  type        = number
  default     = 32
  description = "Storage capacity (GiB) of the file system. Minimum of 32 and maximum of 65536"
}

variable "storage_type" {
  type        = string
  default     = "SSD"
  description = "Specifies the storage type, valid values are SSD and HDD"
  validation {
    condition     = contains(["HDD", "SSD"], var.storage_type)
    error_message = "The storage type value must be HDD or SSD."
  }
}

variable "subnet_ids" {
  type        = list(string)
  description = "Private subnet ID(s) for the Amazon FSx for Windows"
}

variable "throughput_capacity" {
  type        = number
  default     = 16
  description = "Throughput (megabytes per second) of the file system in power of 2 increments. Minimum of 8 and maximum of 2048"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for the Amazon FSx for Windows"
}

variable "self_managed_ad_dns_ips" {
  type        = list(string)
  description = "List of DNS server IP addresses for the self-managed Active Directory"
}

variable "self_managed_ad_domain_name" {
  type        = string
  description = "Fully qualified domain name of the self-managed Active Directory"
}

variable "self_managed_ad_username" {
  type        = string
  description = "Username for the self-managed Active Directory"
}

variable "self_managed_ad_password" {
  type        = string
  description = "Password for the self-managed Active Directory"
}

variable "self_managed_ad_ou" {
  type        = string
  description = "Organizational unit within the self-managed Active Directory"
  default     = "OU=AmazonFSx,DC=YourDomain,DC=com" # Example value
}