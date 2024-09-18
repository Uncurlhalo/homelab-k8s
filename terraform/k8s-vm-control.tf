# Use modules to reference our control plane
module "k8s-control-plane" {
  # reference local module
  source = "./modules/k8s-vm-control"
  providers = {
    proxmox = proxmox.neko
  }

  depends_on = [
    null_resource.cloud_init_config_upload,
  ]

  # Define our variables
  node_name = var.neko.node_name
  control_node_spec = {
    name         = "control"
    count        = 1
    cores        = 4
    memory       = 8192
    vm_id_prefix = "90"
  }
}