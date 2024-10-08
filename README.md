# homelab-k8s

This repo contains the necessary IAC resources to created a self hosted k8s-cluster on a Proxmox hypervisor utilizing Terraform and Kubespray. The current repo represents a minimum viable setup. Currently the terraform modules to stand up the VM's for a cluster are functional and the cluster is configured with some slight modifications from default.

## Requirements and Assumptions

* Proxmox VE v8.1 or greater
* Internet connected network with IP's available in the range `192.168.2.0-192.168.3.255`
* Enough available resources on the host server, explained below
  * 36 CPU cores
  * 64 GB RAM
  * 125 GB disk space available as `local-lvm`
  * 150GB disk space available as `zfs-vm-data`
* Terraform v1.9.5 or greater
* Ansible v2.16.10 or greater
* python3-jsonschema
* python3-netaddr
* python3-jmespath
* python3-distlib

## Usage guide

Begin by cloning this repository into some directory
`git clone https://github.com/Uncurlhalo/homelab-k8s.git`

Fill out the contents of a `.tfvars` file using the provided example. Creating a Proxmox user, API token is out of scope of this project. Creating an SSH keypair is out of scope as well. The Linux image you provide must be in the following formats: `.qcow2, .img, .raw`, and Proxmox expects the image name to end with `.img`.

Run the following commands to initialize terraform and apply the plan to your Proxmox server:

```bash
cd terraform
make init
# optional
# make plan
make apply
```

This will create an `inventory.ini` file in the directory `kubespray/inventory/homelab-k8s`. This repo includes Kubespray as a submodule currently. I hope to move to using ansible-galaxy playbook instead, but this provides the best solution for my active development right now. Read the [kubespray docs](https://github.com/kubernetes-sigs/kubespray) if you need guidance on installing Ansible and the necessary playbook requirements. After completing this the cluster can now be configured by running the following command within the `kubespray` directory:

```bash
ansible-playbook -i invetory/homelab-k8s/invetory.ini --become --become-user=root cluster.yml
```

After the playbook has completed running execute the shell script `install_kubeconfig.sh` in the root directory of the repo to configure kubectl.

From this point you should be able to utilize `kubectl` to interact with the cluster!
