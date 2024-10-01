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

vm_user         = "k8s"
vm_password     = "<my_hashed_password>"
host_public_key = "<my_rsa_public_key>"

vm_dns = {
  domain  = "dns.domain"
  servers = ["192.168.1.1"]
}

loadbalancer_node_count = 1
control_node_count      = 3
worker_node_count       = 3

linux_image_name = "ubuntu-server-noble.img"
linux_image_url  = "https://cloud-images.ubuntu.com/noble/20240912/noble-server-cloudimg-amd64.img"