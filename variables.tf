variable "az_default" {
  description = "Default availability zone"
  type        = string
  default     = "ru-central1-a"
}

variable "folder_id" {
  description = "Folder ID"
  type        = string
  default     = "b1grlgcpgp7enm4j8knb"
}

variable "owner" {
  description = "Owner"
  type        = string
  default     = "ushakou"
}

variable "change_pass" {
  description = "Change password in password generator"
  type        = string
  default     = "1"
}
