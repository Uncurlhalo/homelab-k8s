
resource "proxmox_virtual_environment_file" "cloud-init-haproxy" {
  provider     = proxmox.neko
  node_name    = var.pve.node_name
  content_type = "snippets"
  datastore_id = "local"

  source_raw {
    data = templatefile("./templates/haproxy-user-data.yaml.tftpl", {
      username = var.vm_user
      password = var.vm_password
      pub-key  = var.host_public_key
      lb_ip    = var.lb_pub_ip
      # holy fuck this is a hack, i should not configure this at vm creation. also ew white space
      control_plane_api_endpoints = join("\n", [for host in local.control_nodes : join(" ", ["        server", "${host.hostname}", "${host.ip_pub}:6443 check"])])
    })

    file_name = "haproxy-user-data.yaml"
  }
}

#resource "local_file" "ansible_inventory" {
#  filename = "../ansible//inventory/inventory.ini"
#  content = templatefile("./templates/inventory.ini.tftpl", {
#    control_nodes       = join("\n", [for host in local.control_nodes : join(" ", [host.hostname, "ansible_host=${host.ip_pub}", "ansible_user=k8s-node", "ip=${host.ip_pub}"])])
#    worker_nodes        = join("\n", [for host in local.worker_nodes : join(" ", [host.hostname, "ansible_host=${host.ip_pub}", "ansible_user=k8s-node", "ip=${host.ip_pub}"])])
#    control_nodes_hosts = join("\n", [for host in local.control_nodes : host.hostname])
#    worker_nodes_hosts  = join("\n", [for host in local.worker_nodes : host.hostname])
#  })
#}