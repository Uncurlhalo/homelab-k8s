output "node_info" {
  depends_on = [proxmox_virtual_environment_vm.k8s-node]
  value = [
    for host in proxmox_virtual_environment_vm.k8s-node : {
      "hostname" : host.name
      "ip_pub" : host.ipv4_addresses[1][0]
      "ip_priv" : host.ipv4_addresses[2][0]
    }
  ]
}
