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
# The real solution would be a proper router with some IPAM solution.
variable "vm_public_ip_subnet" {
  description = "Whcih subnet to use (assuming defining a full /24 out of the 3rd octet)"
  type        = string
  default     = "2"
}
variable "vm_public_ip_prefix" {
  description = "Prefix to use for within the /24 (eg x.x.x.1xx, or x.x.x.2xx)"
  type        = string
  default     = "2"
}
variable "vm_public_subnet_cidr" {
  description = "CIDR to append for IP config passed to proxmox"
  type        = string
  default     = "24"
}
# boolean for deciding if we make a zfs disk or not
variable "zfs_disk" {
  description = "Boolean to check if we want to make ZFS disks"
  type        = bool
  default     = false
}