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
variable "control_node_spec" {
    description = "Details of control plane (count and vm specs)"
    type = object({
      name = string
      count = number
      cores = number
      memory = number
    })

    default = {
      name = "control"
      count = 1
      cores = 4
      memory = 8192
    }
}

# Variable for specs of small, med, large worker nodes
variable "worker_node_small_spec" {
    description = "Details of small workers (count and vm specs)"
    type = object({
      name = string
      count = number
      cores = number
      memory = number
    })
    default = {
      name = "small"
      count = 1
      cores = 4
      memory = 8192
    }
}

variable "worker_node_medium_spec" {
    description = "Details of med workers (count and vm specs)"
    type = object({
      name = string
      count = number
      cores = number
      memory = number
    })
    default = {
      name = "medium"
      count = 1
      cores = 8
      memory = 16384
    }
}

variable "worker_node_large_spec" {
    description = "Details of large workers (count and vm specs)"
    type = object({
      name = string
      count = number
      cores = number
      memory = number
    })
    default = {
      name = "large"
      count = 1
      cores = 16
      memory = 32768
    }
}
