resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  content_type = "iso"
  datastore_id = var.datastore_id
  node_name    = var.node_name

  url = var.image_url
}

resource "proxmox_virtual_environment_vm" "this" {
  name      = var.name
  node_name = var.node_name

  template = true
  started  = true

  machine     = "q35"
  bios        = "ovmf"
  description = "Managed by Terraform"

  boot_order    = ["scsi0"]
  scsi_hardware = "virtio-scsi-single"
  tags          = var.tags

  lifecycle {
    ignore_changes = [network_device]
  }

  cpu {
    type    = "x86-64-v2-AES"
    cores   = var.cpu_cores
    sockets = var.cpu_sockets
    flags   = []
  }

  memory {
    dedicated = var.memory
  }

  efi_disk {
    datastore_id = var.datastore_id
    type         = "4m"
  }

  disk {
    datastore_id = var.datastore_id
    file_id      = proxmox_virtual_environment_download_file.ubuntu_cloud_image.id
    interface    = "scsi0"
    size         = var.disk_size
    iothread     = true
    discard      = "ignore"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
    datastore_id = var.datastore_id
    interface    = "ide2"
  }

  network_device {
    bridge = var.network_bridge
    model  = "virtio"
  }
}
