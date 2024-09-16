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