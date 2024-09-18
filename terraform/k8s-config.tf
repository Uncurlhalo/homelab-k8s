resource "proxmox_virtual_environment_download_file" "debian_12_generic_image" {
  provider     = proxmox.neko
  node_name    = var.neko.node_name
  content_type = "iso"
  datastore_id = "local"

  file_name          = "debian-12-genericcloud-amd64-20240901-1857.img"
  url                = "https://cloud.debian.org/images/cloud/bookworm/20240901-1857/debian-12-genericcloud-amd64-20240901-1857.qcow2"
  checksum           = "a901963590db6847252f1f7e48bb99b5bc78c8e38282767433e24682a96ea83aa764a2c8c16ae388faee2ff4176dbf826e8592660cdbf4ebff7bd222b9606da8"
  checksum_algorithm = "sha512"
}

resource "proxmox_virtual_environment_file" "cloud-init" {
  provider     = proxmox.neko
  node_name    = var.neko.node_name
  content_type = "snippets"
  datastore_id = "local"

  source_raw {
    data = templatefile("./cloud-init/k8s-user-data.yaml.tftpl", {
      username = var.vm_user
      password = var.vm_password
      pub-key  = var.host_public_key
    })

    file_name = "cloud-init-k8s.yaml"
  }
}
