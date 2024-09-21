pve = {
  node_name = "my_node"
  endpoint  = "https://my.url.example:8006"
  insecure  = false
}

# you should really not use root
pve_auth = {
  username  = "root"
  api_token = "root@pam!terraform=my_token"

}

vm_user         = "k8s-node"
vm_password     = "my_hashed_password"
host_public_key = "my_rsa_public_key"

vm_dns = {
  domain  = "dns.domain"
  servers = ["192.168.1.3"]
}

control_node_count = 3
worker_node_count = 3