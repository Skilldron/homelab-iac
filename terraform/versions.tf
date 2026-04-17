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

provider "proxmox" {
  endpoint  = "https://proxmox.haroldd.dev/"
  api_token = var.api_token
  insecure  = false
  ssh {
    agent       = false
    private_key = file(pathexpand("~/.ssh/terraform_homelab"))
    username    = "terraform"
  }
}
