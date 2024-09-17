# Use modules to reference our control plane
module "k8s-control-plane" {
  # reference local module
  source = "./modules/k8s-vm-control"

  # Define our variables
  vm_image_id = proxmox_virtual_environment_download_file.debian_12_generic_image.id
  cloud_init_id = proxmox_virtual_environment_file.cloud-init.id
  node_name = var.neko.node_name
  vm_dns = var.vm_dns
  control_node_spec = {
    name         = "control"
    count        = 1
    cores        = 4
    memory       = 8192
    vm_id_prefix = "90"
  }
}
