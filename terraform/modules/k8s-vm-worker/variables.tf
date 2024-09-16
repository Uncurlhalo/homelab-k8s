# Variable for a worker node. Defaults are set to a small size
variable "worker_node_spec" {
    description = "Details of small workers (count and vm specs)"
    type = object({
      name = string
      count = number
      cores = number
      memory = number
      vm_id_prefix = string
    })
    default = {
      name = "small"
      count = 1
      cores = 4
      memory = 4096
      vm_id_prefix = "80"
    }
}