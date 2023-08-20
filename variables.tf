variable "region" {
  description = "Region"
  type        = string
  default     = "us-east-1"
}

variable "owner" {
  description = "Owner"
  type        = string
  default     = "ushakou"
}

variable "cluster_name" {
  description = "Name of cluster"
  type        = string
  default     = "Ushakou-tf-eks"
}

variable "vpc_cidr" {
  description = "CIDR of VPC"
  type        = string
  default     = "10.0.0.0/16"
}

