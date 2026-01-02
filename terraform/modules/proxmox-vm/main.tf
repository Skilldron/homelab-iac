resource "proxmox_virtual_environment_file" "cloud_init" {
  content_type = "snippets"
  datastore_id = var.datastore_id
  node_name    = var.node_name

  source_raw {
    data = templatefile("${path.module}/cloud-init.tf.tmpl", {
      name            = "${var.name}"
      fqdn            = "${var.name}.${var.domain}"
      ssh_key         = trimspace(data.local_file.ssh_public_key_harold.content)
      role            = "${var.role}"
      ssh_key_ansible = trimspace(data.local_file.ssh_public_key_ansible.content)
    })

    file_name = "cloud-init-${var.name}.yaml"
  }
}


resource "proxmox_virtual_environment_vm" "this" {
  name      = var.name
  node_name = var.node_name
  tags      = var.tags

  description = "VM managed by Terraform"

  clone {
    vm_id = var.template_id
  }

  cpu {
    cores   = var.cpu_cores
    sockets = var.cpu_sockets
    type    = "x86-64-v2-AES"
  }

  memory {
    dedicated = var.memory
  }

  network_device {
    bridge = var.network_bridge
    model  = "virtio"
  }

  agent {
    enabled = true
  }

  initialization {
    ip_config {
      ipv4 {
        address = var.ip_address
        gateway = var.gateway
      }
    }
    datastore_id      = var.datastore_id
    interface         = "ide2"
    user_data_file_id = proxmox_virtual_environment_file.cloud_init.id
  }
}
