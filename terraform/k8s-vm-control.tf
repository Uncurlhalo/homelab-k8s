# Use modules to reference our control plane
module "k8s-control-plane" {
  # depend on the config file creations
  depends_on = [proxmox_virtual_environment_download_file.ubuntu_cloud_img, proxmox_virtual_environment_file.cloud-init]
  # reference local module
  source = "./modules/k8s-vm-node"
  providers = {
    proxmox = proxmox.neko
  }

  # Define our variables
  k8s_node_spec = {
    name         = "control-plane"
    count        = var.control_node_count
    cores        = 4
    memory       = 8192
    vm_id_prefix = "30"
    tags         = ["k8s", "control"]
  }

  vm_image_id   = proxmox_virtual_environment_download_file.ubuntu_cloud_img.id
  cloud_init_id = proxmox_virtual_environment_file.cloud-init.id

  node_name = var.pve.node_name
  vm_dns    = var.vm_dns
  zfs_disk = false

  vm_private_ip_prefix = "1"
  vm_public_ip_prefix  = "21"
}