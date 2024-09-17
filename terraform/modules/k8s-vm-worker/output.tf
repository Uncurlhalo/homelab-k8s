output "worker_ipv4_address" {
  depends_on = [proxmox_virtual_environment_vm.k8s-worker]
  value      = proxmox_virtual_environment_vm.k8s-worker[*].ipv4_addresses[1][0]
}

resource "local_file" "worker_ips" {
  content         = join("\n", proxmox_virtual_environment_vm.k8s-worker[*].ipv4_addresses[1][0])
  filename        = "output/worker_${var.worker_node_spec.name}_ips.txt"
  file_permission = "0644"
}
