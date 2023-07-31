variable "az" {
  description = "Availability zone"
  type        = string
  default     = "ru-central1-a"
}

variable "change_pass" {
  description = "Change this var for generating new password"
  type        = string
  default     = "3"
}

variable "db_key" {
  description = "Name of ssm credential for DB in dev environment"
  type        = string
  default     = "db_key"
}


