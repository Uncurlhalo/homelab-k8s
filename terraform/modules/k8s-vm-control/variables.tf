# Variable for a control node.
variable "control_node_spec" {
    description = "Details of control plane (count and vm specs)"
    type = object({
      name = string
      count = number
      cores = number
      memory = number
      vm_id_prefix = string
    })

    default = {
      name = "control"
      count = 1
      cores = 4
      memory = 8192
      vm_id_prefix = "90"
    }
}

variable "cloud_init_id" {
  description = "ID for the cloud-init artifact stored on your PVE node"
  type = string  
}

variable "vm_image_id" {
  description = "ID for the vm image you wish to use for the node"
  type = string  
}

variable "node_name" {
  description = "PVE node to create VM's on"
  type = string  
}

# Define DNS variable so we can set my local DNS server
variable "vm_dns" {
  description = "DNS config for VMs"
  type = object({
    domain  = string
    servers = list(string)
  })
}