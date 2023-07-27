variable "region" {
  description = "Region"
  type        = string
  default     = "us-east-1"
}

variable "az" {
  description = "Availability zone"
  type        = string
  default     = "us-east-1c"
}


variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami" {
  description = "Ubuntu 22.04"
  type        = string
  default     = "ami-053b0d53c279acc90"
}

variable "owner" {
  description = "Owner in tags"
  type        = string
  default     = "Ushakou"
}
