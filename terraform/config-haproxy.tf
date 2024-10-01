resource "proxmox_virtual_environment_file" "cloud-init-haproxy" {
  # depend on worker nodes (which depends on control nodes) so that we can get all the IP's we need to populate
  depends_on   = [module.k8s-cluster-worker]
  provider     = proxmox.neko
  node_name    = var.pve.node_name
  content_type = "snippets"
  datastore_id = "local"

  source_raw {
    data = templatefile("./templates/haproxy-user-data.yaml.tftpl", {
      username = var.vm_user
      password = var.vm_password
      pub-key  = var.host_public_key
    })

    file_name = "haproxy-user-data.yaml"
  }
}