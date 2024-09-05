# varibles for provider information
variable "neko" {
    description = "Neko Proxmox host endpoint variable"
    type = object({
      node_name = string
      endpoint = string
      insecure = bool
    })
}
# Authentication variables for my PVE instance
variable "neko_auth" {
    description = "Neko Proxmox host authentication variable"
    type = object({
      username = string
      api_token = string
    })
    sensitive = true 
}

# variables for cloud-init and later ansible
variable "vm_user" {
    description = "VM Username"
    type = string
}

variable "vm_password" {
    description = "VM Password"
    type = string
    sensitive = true
}

variable "host_public_key" {
    description = "Host SSH public key"
    type = string
}

# Define DNS variable so we can set my local DNS server
variable "vm_dns" {
  description = "DNS config for VMs"
  type        = object({
    domain  = string
    servers = list(string)
  })
}

# Variable for the count of control nodes (2)
variable "control_node_count" {
    description = "Number of control nodes to create"
    type = number
    default = 2 
}

# Variable for count of small, med, large worker nodes
variable "worker_node_small_count" {
    description = "Number of small worker nodes"
    type = number
    default = 8
}

variable "worker_node_med_count" {
    description = "Number of med worker nodes"
    type = number
    default = 4
}

variable "worker_node_large_count" {
    description = "Number of large worker nodes"
    type = number
    default = 2
}