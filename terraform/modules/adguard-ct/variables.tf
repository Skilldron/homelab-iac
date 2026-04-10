variable "api_token" {
  description = "Token to connect Proxmox API"
  type        = string
}

variable "name" {
  type        = string
  description = "Name of the VM"
}

variable "image_url" {
  type        = string
  description = "URL of the Ubuntu image"
}

variable "node_name" {
  type        = string
  description = "Proxmox node"
}

variable "datastore_id" {
  type        = string
  description = "Proxmox datastore"
}

variable "network_bridge" {
  type = string
}

variable "tags" {
  type    = list(string)
  default = []
}

variable "cpu_cores" {
  type    = number
  default = 2
}

variable "cpu_sockets" {
  type    = number
  default = 1
}

variable "memory" {
  type    = number
  default = 2048
}

variable "disk_size" {
  type    = number
  default = 20
}

variable "ip_address" {
  type        = string
  default     = "dhcp"
  description = "IP address for the machine"
}

variable "gateway" {
  type = string
}


