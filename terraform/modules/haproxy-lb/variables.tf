# Variable for a ha-proxy load balancer
variable "ha_proxy_spec" {
  description = "Details of the Load Balancer VM"
  type = object({
    name         = string
    count        = number
    cores        = number
    memory       = number
    vm_id_prefix = string
    tags         = list(string)
  })
  default = {
    name         = "haproxy-lb"
    count        = 1
    cores        = 4
    memory       = 8192
    vm_id_prefix = "30"
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
  description = "PVE node to create VM on"
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

# this is a full IP, defined so that we can know its IP for configuring HAProxy and the DNS record of the load balancer
# otherwise I have a circular dependancy issue. This would'nt be so bad if I had proper IPAM
variable "lb_ip" {
  description = "LB's public IP address"
  type        = string
  default     = "0.0.0.0"
}

# boolean for deciding if we make a zfs disk or not
variable "zfs_disk" {
  description = "Boolean to check if we want to make ZFS disks"
  type        = bool
  default     = false
}

variable "vm_public_subnet_cidr" {
  description = "CIDR to append for IP config passed to proxmox"
  type        = string
  default     = "/24"
}