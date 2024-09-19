# Use modules to reference our 3 worker cluster sizes
module "k8s-workers-small" {
  # depned on control nodes completed and large completed
  depends_on = [module.k8s-workers-medium]
  # reference local module
  source = "./modules/k8s-vm-node"
  providers = {
    proxmox = proxmox.neko
  }

  # Define our variables
  k8s_node_spec = {
    type         = "worker"
    name         = "small"
    count        = var.worker_node_count.small
    cores        = 4
    memory       = 4096
    vm_id_prefix = "51"
    tags         = ["k8s", "worker", "small"]
  }

  vm_image_id   = proxmox_virtual_environment_download_file.ubuntu_cloud_img.id
  cloud_init_id = proxmox_virtual_environment_file.cloud-init.id

  node_name = var.pve.node_name
  vm_dns    = var.vm_dns

  vm_networking_ip_prefix = "21"
}

module "k8s-workers-medium" {
  # depned on control nodes completed and large completed
  depends_on = [module.k8s-workers-large]
  # reference local module
  source = "./modules/k8s-vm-node"
  providers = {
    proxmox = proxmox.neko
  }

  # Define our variables
  k8s_node_spec = {
    type         = "worker"
    name         = "medium"
    count        = var.worker_node_count.medium
    cores        = 8
    memory       = 8192
    vm_id_prefix = "52"
    tags         = ["k8s", "worker", "medium"]
  }

  vm_image_id   = proxmox_virtual_environment_download_file.ubuntu_cloud_img.id
  cloud_init_id = proxmox_virtual_environment_file.cloud-init.id

  node_name = var.pve.node_name
  vm_dns    = var.vm_dns

  vm_networking_ip_prefix = "22"
}

module "k8s-workers-large" {
  # depned on control nodes completed
  depends_on = [module.k8s-control-plane]
  # reference local module
  source = "./modules/k8s-vm-node"
  providers = {
    proxmox = proxmox.neko
  }

  # Define our variables
  k8s_node_spec = {
    type         = "worker"
    name         = "large"
    count        = var.worker_node_count.large
    cores        = 16
    memory       = 16384
    vm_id_prefix = "53"
    tags         = ["k8s", "worker", "large"]
  }

  vm_image_id   = proxmox_virtual_environment_download_file.ubuntu_cloud_img.id
  cloud_init_id = proxmox_virtual_environment_file.cloud-init.id

  node_name = var.pve.node_name
  vm_dns    = var.vm_dns

  vm_networking_ip_prefix = "23"
}