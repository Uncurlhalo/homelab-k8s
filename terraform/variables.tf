# varibles for provider information
variable "neko" {
  description = "Neko Proxmox host endpoint variable"
  type = object({
    hostname        = string
    node_name       = string
    pm_api_url      = string
    pm_tls_insecure = bool
  })
}

# Authentication variables for my PVE instance
variable "neko_auth" {
  description = "Neko Proxmox host authentication variable"
  type = object({
    pm_api_token_id     = string
    pm_api_token_secret = string
    pm_user             = string
    pm_password         = string
  })
  sensitive = true
}

# variables for cloud-init and later ansible
variable "vm_user" {
  description = "VM Username"
  type        = string
}

variable "vm_password" {
  description = "VM Password"
  type        = string
  sensitive   = true
}

variable "host_public_key" {
  description = "Host SSH public key"
  type        = string
}

# Define DNS variable so we can set my local DNS server
variable "vm_dns" {
  description = "DNS config for VMs"
  type = object({
    domain  = string
    servers = list(string)
  })
}