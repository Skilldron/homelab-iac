resource "proxmox_download_file" "ubuntu_lxc_template" {
  content_type = "vztmpl"
  datastore_id = var.datastore_id
  node_name    = var.node_name
  url          = var.image_url
  overwrite    = false
}

resource "proxmox_virtual_environment_container" "adguard" {
  node_name   = var.node_name
  tags        = var.tags
  description = "Serveur DNS AdGuard Home (LXC) managed by Terraform"
  vm_id       = 200

  start_on_boot = true
  unprivileged  = true

  features {
    nesting = true
  }

  network_interface {
    name   = "veth0"
    bridge = var.network_bridge
  }
  cpu {
    architecture = "amd64"
    cores        = 1
  }

  memory {
    dedicated = 512
    swap      = 0
  }

  disk {
    datastore_id = var.datastore_id
    size         = 10
  }

  operating_system {
    template_file_id = proxmox_download_file.ubuntu_lxc_template.id
    type             = "ubuntu"
  }

  initialization {
    hostname = "adguard-dns"

    ip_config {
      ipv4 {
        address = var.ip_address
        gateway = var.gateway
      }
    }

    # Default user is root for LXC containers, so we can directly use the SSH keys for the root user
    user_account {
      keys = [trimspace(data.local_file.ssh_public_key_harold.content), trimspace(data.local_file.ssh_public_key_ansible.content)]
    }
  }
}
