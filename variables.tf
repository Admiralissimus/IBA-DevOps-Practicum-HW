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

