Role Name
=========

`harold.adguard_home` installs AdGuard Home from the official GitHub release
archive and runs it as a dedicated, non-root `systemd` service.

The role is designed for IaC-managed hosts:

- the binary is installed under `/opt/adguard-home` with `root:root` ownership;
- runtime data is stored under `/var/lib/adguardhome`;
- the writable configuration directory is `/etc/adguardhome`;
- the service runs without root by using Linux capabilities scoped in `systemd`;
- in-app auto-updates are disabled so upgrades stay controlled by Ansible.

Requirements
------------

- Debian-family Linux with `systemd`
- facts enabled

Role Variables
--------------

Main variables from `defaults/main.yml`:

- `adguard_home_version`: release to install, default `0.107.73`
- `adguard_home_checksum`: optional override checksum, required when using a
  version that is not bundled in `adguard_home_release_checksums`
- `adguard_home_service_extra_args`: optional extra CLI arguments appended to
  `ExecStart`
- `adguard_home_download_url`: optional override download URL

Behavior
--------

- On the first start, AdGuard Home creates `AdGuardHome.yaml` itself and exposes
  the installation wizard on `0.0.0.0:3000`, which matches the upstream
  behavior.
- The role intentionally does not template `AdGuardHome.yaml`, so configuration
  changes performed from the web UI are preserved across Ansible runs.
- To upgrade, bump `adguard_home_version` and provide the matching
  `adguard_home_checksum` if the version is not already listed in defaults.

Example Playbook
----------------

```yaml
- name: Install AdGuard Home
  hosts: adguard_home
  roles:
    - role: harold.adguard_home
      vars:
        adguard_home_version: "0.107.73"
```

Post-installation
-----------------

Open `http://<server-ip>:3000` to complete the initial wizard, then point your
clients to the host for DNS.

Make sure your network policy allows at least:

- `3000/tcp` for the initial setup wizard
- `53/tcp` and `53/udp` for DNS traffic

License
-------

MIT
