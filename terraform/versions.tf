terraform {
  required_providers {
    ansible = {
      version = "~> 1.3.0"
      source  = "ansible/ansible"
    }
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.89.1"
    }
  }
}

provider "proxmox" {
  endpoint  = "https://192.168.1.10:8006/" # 100.64.136.30 when in VPN, else use local IP address of Proxmox VE host 192.168.1.10
  api_token = var.api_token
  insecure  = true # Should be turned off to false, for now self-signed certs are used until I setup proper CA signed certs
  ssh {
    agent       = false
    private_key = file("~/.ssh/terraform_homelab")
    username    = "terraform"
    # This block is only used when i'm using the VPN
    node {
      name    = "homelab"
      address = "192.168.1.10" #"192.168.1.10"
    }
  }
}
