variable "common_tags" {
  description = "Common Tags to apply to all resources"
  type        = map(any)
  default = {
    owner       = "ushakou"
    environment = "prod"
  }
}

variable "az" {
  description = "Availability zone"
  type        = string
  default     = "ru-central1-a"
}

variable "cidr" {
  description = "CIDR for subnet"
  type        = string
  default     = "10.99.99.0/24"
}

variable "platform_id" {
  description = "Type of cpu"
  type        = string
  default     = "standard-v2"
}

variable "vm_type" {
  description = "Type of VM (cpu, ram)"
  default = {
    cores         = 2
    memory        = 2
    core_fraction = 100
  }
}

variable "os_family_id" {
  description = "OS family id"
  type        = string
  default     = "debian-11"
}


