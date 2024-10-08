#common cloud image to use for all VM's
resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_img" {
  provider     = proxmox.neko
  node_name    = var.pve.node_name
  content_type = "iso"
  datastore_id = "local"

  file_name = var.linux_image_name
  url       = var.linux_image_url
}
