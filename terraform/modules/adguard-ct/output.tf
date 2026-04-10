output "lxc_vm_id" {
  value = proxmox_virtual_environment_container.adguard.vm_id
}

output "lxc_hostname" {
  value = proxmox_virtual_environment_container.adguard.initialization[0].hostname
}

output "lxc_ipv4_address" {
  value = proxmox_virtual_environment_container.adguard.initialization[0].ip_config[0].ipv4[0].address
}
