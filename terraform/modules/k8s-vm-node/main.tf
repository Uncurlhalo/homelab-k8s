terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">=0.63.0"
    }
  }
}

# Generic worker VM resource, utilize variables
resource "proxmox_virtual_environment_vm" "k8s-node" {
  node_name = var.node_name

  # count of number of workers
  count = var.k8s_node_spec.count

  # Start of actual resrouces for vm
  name        = "k8s-${var.k8s_node_spec.type}-${var.k8s_node_spec.name}-${count.index}"
  description = format("kubernetes ${var.k8s_node_spec.type} ${var.k8s_node_spec.name} %02d", count.index)
  on_boot     = true
  vm_id       = format("${var.k8s_node_spec.vm_id_prefix}%02d", count.index)

  tags = var.k8s_node_spec.tags

  machine       = "q35"
  scsi_hardware = "virtio-scsi-pci"
  bios          = "ovmf"

  serial_device {
    device = "socket"
  }

  vga {
    type = "serial0"
  }

  cpu {
    cores = var.k8s_node_spec.cores
    type  = "host"
  }

  memory {
    dedicated = var.k8s_node_spec.memory
  }

  network_device {
    bridge = "vmbr0"
  }

  efi_disk {
    datastore_id = "local-lvm"
    file_format  = "raw"
    type         = "4m"
  }

  # just a local disk, maybe add a zfs data disk later (no idea about performance)
  disk {
    datastore_id = "local-lvm"
    file_id      = var.vm_image_id
    file_format  = "raw"
    interface    = "scsi0"
    cache        = "none"
    backup       = "false"
    size         = 20
  }

  #disk {
  #  datastore_id = "iscsi-lvm"
  #  file_format  = "raw"
  #  interface    = "scsi1"
  #  cache        = "none"
  #  backup       = "false"
  #  size         = 50
  #}

  boot_order = ["scsi0"]

  agent {
    enabled = true
  }

  operating_system {
    type = "l26"
  }

  lifecycle {
    ignore_changes = [
      network_device,
    ]
  }

  # Intial configuration details, includes cloud init
  initialization {
    dns {
      domain  = var.vm_dns.domain
      servers = var.vm_dns.servers
    }
    ip_config {
      ipv4 {
        address = format("192.168.1.${var.vm_networking_ip_prefix}%d/24", count.index)
        gateway = "192.168.1.1"
      }
    }

    interface         = "ide2"
    datastore_id      = "local-lvm"
    user_data_file_id = var.cloud_init_id
  }
}