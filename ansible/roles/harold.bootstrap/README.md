# harold.bootstrap

Bootstrap role used to prepare hosts with base packages and shell tooling.

## LXC init mode

Set `bootstrap_lxc_init: true` to enable first-boot initialization for LXC
containers that do not use cloud-init.

When enabled, the role:

- ensures `/root/.ssh/authorized_keys` exists
- creates `ansible` and `ubuntu` users
- copies root SSH authorized keys to those users
- configures `NOPASSWD` sudo for `ansible` and `ubuntu`
- sets the host timezone (`bootstrap_timezone`)
- deploys SSH hardening drop-in

### Main variables

- `bootstrap_lxc_init` (bool, default: `false`)
- `bootstrap_timezone` (string, default: `Europe/Paris`)
- `bootstrap_lxc_users` (list, default: `["ansible", "ubuntu"]`)
- `bootstrap_sudo_nopasswd_users` (list, default: `["ansible", "ubuntu"]`)
- `bootstrap_ssh_hardening` (bool, default: `true`)
- `bootstrap_sshd_service_name` (string, default: `ssh`)

### Example run for LXC

```bash
ansible-playbook ansible/playbooks/bootstrap.yml -l adguard -e bootstrap_lxc_init=true
```
