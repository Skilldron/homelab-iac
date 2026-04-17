data "local_file" "ssh_public_key_harold" {
  filename = pathexpand("~/.ssh/harold_user_homelab.pub")
}

data "local_file" "ssh_public_key_ansible" {
  filename = pathexpand("~/.ssh/ansible_homelab.pub")
}
