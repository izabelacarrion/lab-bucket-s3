variable "environment" {
  type        = string
  description = "Define ambiente se Prod ou Staging"
  validation {
    condition     = contains(["izac_srv_prod", "izac_srv_stag"], var.environment)
    error_message = "O valor passado só pode ser srv_prod ou srv_stag"
  }
}