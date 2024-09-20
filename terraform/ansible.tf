locals {
  depends_on    = [module.k8s-control-plane, module.k8s-workers-large, module.k8s-workers-medium, module.k8s-workers-small]
  control_nodes = module.k8s-control-plane.node_info
  worker_nodes  = concat(module.k8s-workers-large.node_info, module.k8s-workers-medium.node_info, module.k8s-workers-small.node_info)
}

resource "local_file" "ansible_inventory" {
  filename = "../ansible//inventory/inventory.ini"
  content = templatefile("./templates/inventory.ini.tftpl", {
    control_nodes = join("\n", [for host in local.control_nodes : join(" ", [host.hostname, "ansible_host=${host.ip}"])])
    worker_nodes  = join("\n", [for host in local.worker_nodes : join(" ", [host.hostname, "ansible_host=${host.ip}"])])
  })
}