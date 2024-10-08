output "node_info" {
  depends_on = [proxmox_virtual_environment_vm.haproxy-lb]
  value = [
    for host in proxmox_virtual_environment_vm.haproxy-lb : {
      "hostname" : host.name
      "ip_pub" : host.ipv4_addresses[1][0]
    }
  ]
}
