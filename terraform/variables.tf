# varibles for provider
variable "neko" {
    description = "Neko Proxmox host endpoint variable"
    type = object({
      node_name = string
      endpoint = string
      insecure = bool
    })
}

variable "neko_auth" {
    description = "Neko Proxmox host authentication variable"
    type = object({
      usernam = string
      api_token = string
    })
    sensitive = true 
}

# variables for cloud-init and later ansible
variable "vm_user" {
    description = "VM Username"
    type = string
  
}