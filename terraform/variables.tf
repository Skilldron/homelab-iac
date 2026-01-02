variable "api_token" {
  description = "Token to connect Proxmox API"
  type        = string
}

variable "virtual_environment_node_name" {
  description = "Proxmox node"
  type        = string
  default     = "homelab"
}

variable "datastore_id" {
  description = "Proxmox datastore ID"
  type        = string
  default     = "local"
}

variable "vms" {
  description = "List of VMs to create"
  type = map(object({
    cpu         = number
    memory      = number
    tags        = list(string)
    ip_address  = string
    gateway     = string
    cpu_sockets = number
    role        = string
  }))
}
