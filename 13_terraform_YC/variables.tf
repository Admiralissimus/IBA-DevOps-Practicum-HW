variable "az_default" {
  description = "Default availability zone"
  type        = string
  default     = "ru-central1-a"
}

variable "platform_id" {
  description = "Type if instances"
  type        = string
  default     = "standard-v2"
}

variable "os_family_id" {
  description = "OS family id"
  type        = string
  default     = "debian-11"
}

variable "owner" {
  description = "Owner in labels"
  type        = string
  default     = "ushakou"
}

variable "server1_subnet_id" {
  description = "default subnet id"
  type        = string
  default     = "e2l73ma11v7l0jjq309c"
}

variable "cidr2" {
  description = "CIDR for subnet 2"
  type        = string
  default     = "10.99.99.0/24"
}

variable "az2" {
  description = "AZ for subnet 2"
  type        = string
  default     = "ru-central1-a"
}

