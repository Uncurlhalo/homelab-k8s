terraform {
  required_providers {
    proxmox = {
        source = "bpg/proxmox"
        version = "0.63.0"
    }
  }
}

# Generic worker VM resource, utilize variables
resource "proxmox_virtual_environment_vm" "k8s-worker" {
  node_name = var.node_name

  # count of number of workers
  count = var.worker_node_spec.count

  # Start of actual resrouces for vm
  name        = "k8s-worker-small-${count.index}"
  description = format("Kubernetes Small Worker %02d", count.index)
  on_boot     = true
  vm_id       = format("${var.worker_node_spec.vm_id_prefix}%02d", count.index)

  tags = ["k8s", "worker"]

  machine       = "q35"
  scsi_hardware = "virtio-scsi-pci"
  bios          = "ovmf"

  cpu {
    cores = var.worker_node_spec.cores
    type  = "host"
  }

  memory {
    dedicated = var.worker_node_spec.memory
  }

  network_device {
    bridge = "vmbr0"
  }

  efi_disk {
    datastore_id = "lvm-iscsi"
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

  # Intial configuration details, includes cloud init
  initialization {
    dns {
      domain  = var.vm_dns.domain
      servers = var.vm_dns.servers
    }
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    datastore_id      = "local"
    user_data_file_id = var.cloud_init_id
  }
}