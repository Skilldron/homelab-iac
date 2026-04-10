data "local_file" "ssh_public_key_harold" {
  filename = "/Users/harold/.ssh/harold_user_homelab.pub"
}

data "local_file" "ssh_public_key_ansible" {
  filename = "/Users/harold/.ssh/ansible_homelab.pub"
}
