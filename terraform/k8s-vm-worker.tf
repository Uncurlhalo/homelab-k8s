# Use modules to reference our 3 worker cluster sizes
module "k8s-workers" {
  # depned on control nodes completed and large completed
  depends_on = [module.k8s-control-plane]
  # reference local module
  source = "./modules/k8s-vm-node"
  providers = {
    proxmox = proxmox.neko
  }

  # Define our variables
  k8s_node_spec = {
    name         = "worker-node"
    count        = var.worker_node_count
    cores        = 4
    memory       = 4096
    vm_id_prefix = "31"
    tags         = ["k8s", "worker"]
  }

  vm_image_id   = proxmox_virtual_environment_download_file.ubuntu_cloud_img.id
  cloud_init_id = proxmox_virtual_environment_file.cloud-init.id

  node_name = var.pve.node_name
  vm_dns    = var.vm_dns
  zfs_disk  = true

  vm_private_ip_prefix = "2"
  vm_public_ip_prefix  = "22"
}