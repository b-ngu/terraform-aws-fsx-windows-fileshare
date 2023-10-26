variable "region" {
  type        = string
  description = "The default region for the test."
  default     = ""
}

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