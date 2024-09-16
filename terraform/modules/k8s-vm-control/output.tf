output "control_ipv4_address" {
  depends_on = [proxmox_virtual_environment_vm.k8s-control-plane]
  value      = proxmox_virtual_environment_vm.k8s-control-plane[*].ipv4_addresses[1][0]
}

resource "local_file" "control_plane_ips" {
  content         = join("\n", proxmox_virtual_environment_vm.k8s-control-plane[*].ipv4_addresses[1][0])
  filename        = "output/control_plane_ips.txt"
  file_permission = "0644"
}