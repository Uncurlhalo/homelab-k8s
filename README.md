# homelab-k8s

This repo contains the necessary IAC resources to created a self hosted k8s-cluster on a Proxmox hypervisor utilizing Terraform and Kubespray. It is under active development and not yet complete. Currently the terraform modules to stand up the VM's for a cluster are functional and can be configured with a basic kubernetes cluster.

## Requirements and Assumptions

* Proxmox VE v8.1 or greater
* Internet connected network with IP's available in the range `192.168.1.200-192.168.1.229`
* Enough available resources on the host server, explained below
  * 36 CPU cores
  * 64 GB RAM
  * 125 GB disk space available as `local-lvm`
  * 150GB disk space available as `zfs-vm-data`
* Terraform v1.9.5 or greater
* Ansible + Ansible Galaxy v2.16.10 or greater
* python3-jsonschema
* python3-netaddr
* python3-jmespath
* python3-distlib

## Usage guide

Begin by cloning this repository into some directory
`git clone https://github.com/Uncurlhalo/homelab-k8s.git`

Fill out the contents of a `.tfvars` file using the provided example. Creating a Proxmox user, API token is out of scope of this project. Creating an SSH keypair is out of scope as well. The Linux image you provide must be in the following formats: `.qcow2, .img, .raw`, and Proxmox expects the image name to end with `.img`.

Run the following commands to initialize terraform and apply the plan to your Proxmox server:
```
cd terraform
make init
# optional
# make plan
make apply
```

This will create an `inventory.ini` file in the `ansible` directory. Run the following commands to apply a configuration to the cluster with Ansible and Kubespray:
```
cd ../ansible
ansible-galaxy install -r requirements.yml
ansible-playbook -i invetory/invetory.ini --become --become-user=root cluster-install.yml
```

The results will be a kubernetes cluster with 3 control-plane nodes with stacked etcd and 3 worker nodes. Currently kubespray does not correctly create a local copy of the kubeconf file from the hosts. SSH into any of the nodes as the user `k8s-node`. The admin.conf file will contain the requisit configuration to use `kubectl` from other machines. It is necessary to change IP of the server to that of one of the control-plane nodes. A planned enhancement will utilize an HA-proxy node to provide a DNS name to resolve the clusters control plane and load balance requests.

From this point you should be able to utilize `kubectl` to interact with the cluster!

## Planned enhancements

* HA mode behind a load-balancer and a DNS record
* Custom cluster options configured via `group_vars` for kubespray
  * Helm
  * external-dns
  * Cilium CNI
  * monitoring and metrics
  * cert-manager
  * Nginx Ingress