# Use modules to reference our control plane
module "k8s-api-loadbalancer" {
  depends_on = [module.k8s-cluster-worker]
  # reference local module
  source = "./modules/haproxy-lb"
  providers = {
    proxmox = proxmox.neko
  }

  # Define our variables
  ha_proxy_spec = {
    name         = "haproxy-lb"
    count        = var.loadbalancer_node_count
    cores        = 4
    memory       = 4096
    vm_id_prefix = "30"
    tags         = ["k8s", "loadbalancer"]
  }

  vm_image_id   = proxmox_virtual_environment_download_file.ubuntu_cloud_img.id
  cloud_init_id = proxmox_virtual_environment_file.cloud-init-haproxy.id

  node_name = var.pve.node_name
  vm_dns    = var.vm_dns
  zfs_disk  = false

  lb_ip = var.lb_pub_ip
}