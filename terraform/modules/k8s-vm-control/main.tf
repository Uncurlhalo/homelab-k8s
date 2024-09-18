terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc4"
    }
  }
}

# Generic worker VM resource, utilize variables
resource "proxmox_vm_qemu" "k8s-control-plane" {
  # count of number of control nodes
  count = var.control_node_spec.count

  # Start of actual resrouces for vm
  name        = "k8s-control-${count.index}"
  target_node = var.node_name

  vmid    = format("${var.control_node_spec.vm_id_prefix}%02d", count.index)
  desc    = format("Kubernetes Control Plane %02d", count.index)
  tags    = "k8s,control-plane"
  os_type = "cloud-init"

  # clone my existing template
  clone = "ubuntu-cloud-init-template"

  # start at boot
  onboot = true

  # expect qemu-agent to be enabled and tell it we are booting linux guests
  agent   = 1
  qemu_os = "l26"
  scsihw  = "virtio-scsi-pci"

  # define resources
  cpu     = "host"
  cores   = var.control_node_spec.cores
  sockets = 1

  # define memory
  memory = var.control_node_spec.memory

  # specify our custom userdata script
  cicustom = "user:local:snippets/k8s-user-data.yml"

  # create my disks
  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "local"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          size    = "20G"
          storage = "local-lvm"
          format  = "raw"
          cache   = "none"
          backup  = false
        }
      }
    }
  }

  # define network interfaces
  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  ipconfig0 = format("ip=192.168.1.2%02d/24,gw=192.168.1.1", count.index)
}