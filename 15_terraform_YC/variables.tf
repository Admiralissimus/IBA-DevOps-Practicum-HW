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

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = ["ru-central1-a", "ru-central1-b"]
}

variable "subnets" {
  description = "Subnets map"
  default = {
    public  = [["10.1.0.0/24"], ["10.2.0.0/24"]]
    private = [["10.4.0.0/24"], ["10.5.0.0/24"]]
  }
}
