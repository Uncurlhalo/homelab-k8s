# Variable for a k8s node. Defaults are set to a small size worker
variable "k8s_node_spec" {
  description = "Details of the k8s node (name, count, and vm specs)"
  type = object({
    name         = string
    count        = number
    cores        = number
    memory       = number
    vm_id_prefix = string
    tags         = list(string)
  })
  default = {
    name         = "k8s-node"
    count        = 1
    cores        = 4
    memory       = 8192
    vm_id_prefix = "80"
    tags         = ["k8s"]
  }
}

variable "cloud_init_id" {
  description = "ID for the cloud-init artifact stored on your PVE node"
  type        = string
}

variable "vm_image_id" {
  description = "ID for the vm image you wish to use for the node"
  type        = string

}

variable "node_name" {
  description = "PVE node to create VM's on"
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

# Define IP prefix for static IPs, not by defining the first 2 numbers it limits us to a max count of 10 ip's
# this really isnt a great solution but i have a shittry router that can only handle a /24. If i migrate to 
# something that can handle a /8 i can just use a different address range eg. 10.0.1.(whatever)
variable "vm_public_ip_prefix" {
  description = "Last IP octect prefix"
  type        = string
  default     = "20"
}

variable "vm_private_ip_prefix" {
  description = "An integer represetning the 3rd octect value for our private IP's"
  type        = string
  default     = "1"
}

# boolean for deciding if we make a zfs disk or not
variable "zfs_disk" {
  description = "Boolean to check if we want to make ZFS disks"
  type        = bool
  default     = false
}