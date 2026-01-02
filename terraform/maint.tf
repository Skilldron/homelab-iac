module "ubuntu_template" {
  source    = "./modules/proxmox-ubuntu-template"
  api_token = var.api_token

  name      = "ubuntu-jammy-template"
  node_name = var.virtual_environment_node_name

  datastore_id = var.datastore_id
  image_url    = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"

  network_bridge = "vmbr0"

}

module "vms" {
  source    = "./modules/proxmox-vm"
  api_token = var.api_token

  for_each = var.vms

  name         = each.key
  node_name    = var.virtual_environment_node_name
  role         = each.value.role
  template_id  = module.ubuntu_template.template_id
  datastore_id = var.datastore_id

  #   cloud_init_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id
  network_bridge = "vmbr0"

  cpu_cores   = each.value.cpu
  cpu_sockets = each.value.cpu_sockets
  memory      = each.value.memory
  tags        = each.value.tags
  ip_address  = each.value.ip_address
  gateway     = each.value.gateway
}
