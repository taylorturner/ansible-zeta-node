# zetachain_project
This repo contains an Ansible playbook for configuring a ZetaChain RPC node and Prometheus/Grafana for monitoring. Additionally there is a playbook for automating the process of jailing/unjailing a validator node.

Grafana: http://localhost:3000
Prometheus: http://localhost:9001

## Setup
#### Prerequisites
1. Ubuntu 22.04 server (ARM64)
2. Able to login as `ubuntu` user using SSH key
3. Passwordless sudo for `ubuntu` user
4. SSH via port 22

Steps to do this with UTM:
1. Create new VM from Ubuntu 22.04 server .iso
2. Go through installation, name server, import keys from github.com, setup user `ubuntu`
3. Poweroff VM
4. Edit VM, remove bootable drive
5. Start VM
6. Login and configure passwordless sudo with `sudo visudo` command

#### Setup RPC Node
The following steps will deploy an RPC node.

1. Paste IP into `testnet.ini` under `[nodes]`, also add an incremented `node_name`
2. Verify `group_vars/all.yml` has the path to your SSH private key
3. Run playbook `ansible-playbook -i testnet.ini provision.yml`

#### Convert to Core Validator node
1. Successfull run the above steps to **Setup RPC Node**
2. See instructions at https://www.zetachain.com/docs/nodes/validate/validator/

#### Manage Validator Nodes
_Make sure you first complete the above steps to setup RPC node and then convert to Core Validator node._

Setup
1. Add the node IP and `node_name` to `testnet.ini` under `[validator_nodes]`

To unjail the node
1. Ensure `force_jailing: false` in `group_vars/all.yml`
2. Run playbook `ansible-playbook -i testnet.ini manage.yml`

To force jail the node
1. Change `force_jailing: true` in `group_vars/all.yml`
2. Run playbook `ansible-playbook -i testnet.ini manage.yml`

## Improvements
The following is a list of improvements I'd like to make:
- Observability
  - Install Grafana Alloy to act as Prometheus Exporter and OpenTelemetry Collector
  - Add opentelemetry-go-instrumentation to auto-instrument the Go executables
- Core Validator automation
  - Setup
  - Backup/restore
