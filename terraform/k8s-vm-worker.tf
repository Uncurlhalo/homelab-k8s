# Use modules to reference our 3 worker cluster sizes
module "k8s-workers-small" {
  # reference local module
  source = "./modules/k8s-vm-worker"
  providers = {
    proxmox = proxmox.neko
  }


  # Define our variables
  vm_image_id   = proxmox_virtual_environment_download_file.debian_12_generic_image.id
  cloud_init_id = proxmox_virtual_environment_file.cloud-init.id
  node_name     = var.neko.node_name
  vm_dns        = var.vm_dns
  worker_node_spec = {
    name         = "small"
    count        = 1
    cores        = 4
    memory       = 4096
    vm_id_prefix = "80"
  }
}

module "k8s-workers-medium" {
  # reference local module
  source = "./modules/k8s-vm-worker"
  providers = {
    proxmox = proxmox.neko
  }


  # Define our variables
  vm_image_id   = proxmox_virtual_environment_download_file.debian_12_generic_image.id
  cloud_init_id = proxmox_virtual_environment_file.cloud-init.id
  node_name     = var.neko.node_name
  vm_dns        = var.vm_dns
  worker_node_spec = {
    name         = "medium"
    count        = 1
    cores        = 8
    memory       = 8192
    vm_id_prefix = "81"
  }
}

module "k8s-workers-large" {
  # reference local module
  source = "./modules/k8s-vm-worker"
  providers = {
    proxmox = proxmox.neko
  }

  # Define our variables
  vm_image_id   = proxmox_virtual_environment_download_file.debian_12_generic_image.id
  cloud_init_id = proxmox_virtual_environment_file.cloud-init.id
  node_name     = var.neko.node_name
  vm_dns        = var.vm_dns
  worker_node_spec = {
    name         = "large"
    count        = 1
    cores        = 16
    memory       = 16384
    vm_id_prefix = "82"
  }
}