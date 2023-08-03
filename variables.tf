variable "region" {
  description = "Region"
  type        = string
  default     = "us-east-1"
}

variable "change_pass" {
  description = "Change this var for generating new password"
  type        = string
  default     = "4"
}

variable "owner" {
  description = "Owner"
  type        = string
  default     = "ushakou"
}
