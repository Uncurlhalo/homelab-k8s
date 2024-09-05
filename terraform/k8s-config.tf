resource "proxmox_virtual_environment_download_file" "debian_12_generic_image" {
  provider           = proxmox.neko
  node_name          = var.neko.node_name
  content_type       = "iso"
  datastore_id       = "local"

  file_name          = "debian-12-generic-amd64-20240901-1857.img"
  url                = "https://cloud.debian.org/images/cloud/bookworm/20240901-1857/debian-12-generic-amd64-20240901-1857.qcow2"
  checksum           = "58a8c91bcaf4e60e32e8153577726a5a68d55def99566b6e5c343b12ba51c24b98b1bc227e59a39f2750a512107d9ca73e59bfc2ed649600fb62098803615942"
  checksum_algorithm = "sha512"
}

resource "proxmox_virtual_environment_file" "cloud-init" {
  provider     = proxmox.neko
  node_name    = var.neko.node_name
  content_type = "snippets"
  datastore_id = "local"

  source_raw {
    data = templatefile("./cloud-init/k8s-user-data.yaml.tftpl", {
      username    = var.vm_user
      password    = var.vm_password
      pub-key     = var.host_public_key
    })

    file_name = "cloud-init-k8s.yaml"
  }
}
