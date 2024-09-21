resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_img" {
  provider     = proxmox.neko
  node_name    = var.pve.node_name
  content_type = "iso"
  datastore_id = "local"

  file_name = vars.linux_image_name
  url       = vars.linux_image_url
}

resource "proxmox_virtual_environment_file" "cloud-init" {
  provider     = proxmox.neko
  node_name    = var.pve.node_name
  content_type = "snippets"
  datastore_id = "local"

  source_raw {
    data = templatefile("./templates/k8s-user-data.yaml.tftpl", {
      username = var.vm_user
      password = var.vm_password
      pub-key  = var.host_public_key
    })

    file_name = "cloud-init-k8s.yaml"
  }
}