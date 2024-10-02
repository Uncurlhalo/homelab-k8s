resource "pihole_dns_record" "control-nodes" {
  for_each = {
    for index, host in module.k8s-cluster-control.node_info :
    host.hostname => host
  }
  ip     = each.value.ip_pub
  domain = "${each.value.hostname}.melton.network"
}

resource "pihole_dns_record" "worker-nodes" {
  for_each = {
    for index, host in module.k8s-cluster-worker.node_info :
    host.hostname => host
  }
  ip     = each.value.ip_pub
  domain = "${each.value.hostname}.melton.network"
}

resource "pihole_dns_record" "haproxy-lb" {
  domain = "k8s-api.melton.network"
  ip     = var.lb_pub_ip
}