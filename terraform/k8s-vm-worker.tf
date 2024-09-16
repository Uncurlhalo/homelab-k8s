# Use modules to reference our 3 worker cluster sizes
module "k8s-workers-small" {
  # reference local module
  source = "./modules/k8s-vm-worker"

  # Define our variables
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
  
  # Define our variables
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

  # Define our variables
  worker_node_spec = {
    name         = "small"
    count        = 1
    cores        = 16
    memory       = 16384
    vm_id_prefix = "82"
  }
}