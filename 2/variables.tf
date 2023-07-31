variable "region" {
  description = "Region"
  type        = string
  default     = "us-east-1"
}

variable "change_pass" {
  description = "Change this var for generating new password"
  type        = string
  default     = "2"
}

variable "dev_db_ssm" {
  description = "Name of ssm credential for DB in dev environment"
  type        = string
  default     = "db_dev_ssm"
}


