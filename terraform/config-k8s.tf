resource "proxmox_virtual_environment_file" "cloud-init-k8s" {
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

    file_name = "k8s-user-data.yaml"
  }
}