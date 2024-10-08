# varibles for provider information
variable "pve" {
  description = "Neko Proxmox host endpoint variable"
  type = object({
    node_name = string
    endpoint  = string
    insecure  = bool
  })
}
# Authentication variables for my PVE instance
variable "pve_auth" {
  description = "Neko Proxmox host authentication variable"
  type = object({
    username  = string
    api_token = string
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
variable "vm_dns" {
  description = "VM DNS details to pass cloud-init"
  type = object({
    domain  = string
    servers = list(string)
  })
}
variable "loadbalancer_node_count" {
  description = "Desired number of HAProxy load balancers"
  type        = number
  default     = 1
}
variable "control_node_count" {
  description = "Desired number of control nodes"
  type        = number
  default     = 1
}
variable "worker_node_count" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 1
}
variable "linux_image_name" {
  description = "Name of the linux image you want to use. (must be .img)"
  type        = string
}
variable "linux_image_url" {
  description = "Url to the linux image you want to use"
  type        = string
}
variable "lb_pub_ip" {
  description = "Public network IP of the loadbalancer we will create"
  type        = string
  default     = "0.0.0.0"
}
variable "pihole_url" {
  description = "URL of pi-hole on your newtork"
  type        = string
}
variable "pihole_api_token" {
  description = "API Token for authing with your pi-hole"
  type        = string
  sensitive   = true
}