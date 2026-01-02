variable "api_token" {
  description = "Token to connect Proxmox API"
  type        = string
}

variable "name" {
  type        = string
  description = "Template name"
}

variable "node_name" {
  type        = string
  description = "Proxmox node"
}

variable "datastore_id" {
  type        = string
  description = "Proxmox datastore"
}

variable "image_url" {
  type        = string
  description = "URL of the Ubuntu cloud image"
}

variable "network_bridge" {
  type = string
}

variable "tags" {
  type    = list(string)
  default = ["ubuntu"]
}

variable "cpu_cores" {
  type    = number
  default = 2
}

variable "cpu_sockets" {
  type    = number
  default = 2
}

variable "memory" {
  type    = number
  default = 2048
}

variable "disk_size" {
  type    = number
  default = 20
}
