locals {
  depends_on    = [module.k8s-control-plane, module.k8s-workers]
  control_nodes = module.k8s-control-plane.node_info
  worker_nodes  = module.k8s-workers.node_info
}

resource "local_file" "ansible_inventory" {
  filename = "../ansible//inventory/inventory.ini"
  content = templatefile("./templates/inventory.ini.tftpl", {
    control_nodes       = join("\n", [for host in local.control_nodes : join(" ", [host.hostname, "ansible_host=${host.ip_pub}", "ansible_user=k8s-node", "ip=${host.ip_pub}", "access_ip=${host.ip_priv}"])])
    worker_nodes        = join("\n", [for host in local.worker_nodes : join(" ", [host.hostname, "ansible_host=${host.ip_pub}", "ansible_user=k8s-node", "ip=${host.ip_pub}", "access_ip=${host.ip_priv}"])])
    control_nodes_hosts = join("\n", [for host in local.control_nodes : host.hostname])
    worker_nodes_hosts  = join("\n", [for host in local.worker_nodes : host.hostname])
  })
}