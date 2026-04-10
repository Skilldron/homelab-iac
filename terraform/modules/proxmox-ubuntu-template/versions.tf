terraform {
  required_providers {
    ansible = {
      version = "~> 1.3.0"
      source  = "ansible/ansible"
    }
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.101.0"
    }
  }
}
