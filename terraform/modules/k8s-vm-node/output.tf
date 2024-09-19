output "node_ipv4_address" {
  depends_on = [proxmox_virtual_environment_vm.k8s-node]
  value      = proxmox_virtual_environment_vm.k8s-node[*].ipv4_addresses[1][0]
}

resource "local_file" "node_ips" {
  content         = join("\n", proxmox_virtual_environment_vm.k8s-node[*].ipv4_addresses[1][0])
  filename        = "output/k8s-${var.k8s_node_spec.type}-${var.k8s_node_spec.name}-ips.txt"
  file_permission = "0644"
}
