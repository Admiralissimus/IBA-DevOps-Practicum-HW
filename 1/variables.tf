variable "region" {
  description = "Region"
  type        = string
  default     = "us-east-1"
}

variable "az" {
  description = "Number of AZ from 0 to ..."
  type        = number
  default     = 0
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t3.micro"
}

variable "common_tags" {
  description = "Common Tags to apply to all resources"
  type        = map(any)
  default = {
    Owner       = "Ushakou"
    Environment = "prod"
  }
}
