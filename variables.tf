variable "aciUsername" {
  type        = string
  description = "ACI Username"
  default     = ""
}
variable "aciPassword" {
  type        = string
  sensitive   = true
  default     = ""
  description = "Password for ACI"
}
variable "aciUrl" {
  type        = string
  default     = ""
  description = "URL of the ACI"
}

variable "tenantName" {
  type        = string
  default     = ""
  description = "ACI Tenant Name"
}