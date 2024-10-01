# Use modules to reference our control plane
module "k8s-cluster-control" {
  # reference local module
  source = "./modules/k8s-node"
  providers = {
    proxmox = proxmox.neko
  }

  # Define our variables
  k8s_node_spec = {
    name         = "control-node"
    count        = var.control_node_count
    cores        = 4
    memory       = 8192
    vm_id_prefix = "31"
    tags         = ["k8s", "control"]
  }

  vm_image_id   = proxmox_virtual_environment_download_file.ubuntu_cloud_img.id
  cloud_init_id = proxmox_virtual_environment_file.cloud-init-k8s.id

  node_name = var.pve.node_name
  vm_dns    = var.vm_dns
  zfs_disk  = false

  vm_public_ip_prefix = "21"
}