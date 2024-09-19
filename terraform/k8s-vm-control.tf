# Use modules to reference our control plane
module "k8s-control-plane" {
  # reference local module
  source = "./modules/k8s-vm-node"
  providers = {
    proxmox = proxmox.neko
  }

  depends_on = [
    null_resource.cloud_init_config_upload,
  ]

  # Define our variables
  k8s_node_spec = {
    type         = "control"
    name         = "plane"
    count        = 1
    cores        = 4
    memory       = 8192
    vm_id_prefix = "50"
    tags         = ["k8s", "control"]
  }

  vm_image_id   = proxmox_virtual_environment_download_file.ubuntu_cloud_img.id
  cloud_init_id = proxmox_virtual_environment_file.cloud-init.id

  node_name = var.neko.node_name
  vm_dns    = var.vm_dns

  vm_networking_ip_prefix = "20"
}