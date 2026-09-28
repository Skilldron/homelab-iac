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
      ip_address      = var.ip_address
      gateway         = var.gateway
    })

    file_name = "cloud-init-${var.name}.yaml"
  }
}


resource "proxmox_virtual_environment_vm" "this" {
  name      = var.name
  vm_id     = var.vm_id
  node_name = var.node_name
  tags      = var.tags


  description = "VM managed by Terraform"

  # Must match the template: provider defaults (seabios, pc, virtio-scsi-pci)
  # would otherwise override the cloned values and break UEFI boot.
  machine       = "q35"
  bios          = "ovmf"
  scsi_hardware = "virtio-scsi-single"

  lifecycle {
    ignore_changes = [
      initialization,
      # Not readable after an import
      clone
    ]
  }

  clone {
    vm_id = var.template_id
  }

  cpu {
    cores   = var.cpu_cores
    sockets = var.cpu_sockets
    type    = var.cpu_type
  }

  memory {
    dedicated = var.memory
  }

  # Inherited from the template, declared so the provider does not remove it
  efi_disk {
    datastore_id = var.datastore_id
    file_format  = "raw"
    type         = "4m"
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
