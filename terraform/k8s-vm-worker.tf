# Use modules to reference our 3 worker cluster sizes
module "k8s-workers-small" {
  # reference local module
  source = "./modules/k8s-vm-worker"
  providers = {
    proxmox = proxmox.neko
  }

  # Define our variables
  node_name = var.neko.node_name

  worker_node_spec = {
    name         = "small"
    count        = 1
    cores        = 4
    memory       = 4096
    vm_id_prefix = "60"
  }
}

module "k8s-workers-medium" {
  # reference local module
  source = "./modules/k8s-vm-worker"
  providers = {
    proxmox = proxmox.neko
  }

  # Define our variables
  node_name = var.neko.node_name
  worker_node_spec = {
    name         = "medium"
    count        = 1
    cores        = 8
    memory       = 8192
    vm_id_prefix = "61"
  }
}

module "k8s-workers-large" {
  # reference local module
  source = "./modules/k8s-vm-worker"
  providers = {
    proxmox = proxmox.neko
  }

  # Define our variables
  node_name = var.neko.node_name
  worker_node_spec = {
    name         = "large"
    count        = 1
    cores        = 16
    memory       = 16384
    vm_id_prefix = "62"
  }
}