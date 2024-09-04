resource "pve_vm_image" "debian_12_generic_image" {
  provider           = proxmox.neko
  node_name          = var.neko.node_name
  content_type       = "iso"
  datastore_id       = "local"
  
  file_name          = "debian-12-generic-amd64-20240901-1857.img"
  url                = "https://cloud.debian.org/images/cloud/bookworm/20240901-1857/debian-12-generic-amd64-20240901-1857.qcow2"
  checksum           = "58a8c91bcaf4e60e32e8153577726a5a68d55def99566b6e5c343b12ba51c24b98b1bc227e59a39f2750a512107d9ca73e59bfc2ed649600fb62098803615942"
  checksum_algorithm = "sha512"
}
