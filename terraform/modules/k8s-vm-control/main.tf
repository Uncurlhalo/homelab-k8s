terraform {
  required_providers {
    proxmox = {
        source = "bpg/proxmox"
        version = "0.63.0"
    }
  }
}

resource "proxmox_virtual_environment_vm" "k8s-control-plane" {
  node_name = var.node_name

  # count of number of control nodes
  count = var.control_node_spec.count

  # Start of actual resrouces for vm
  name        = "k8s-control-${count.index}"
  description = format("Kubernetes Control Plane %02d", count.index)
  on_boot     = true
  vm_id       = format("${var.control_node_spec.vm_id_prefix}%02d", count.index)

  tags = ["k8s", "control-plane"]

  machine       = "q35"
  scsi_hardware = "virtio-scsi-pci"
  bios          = "ovmf"

  cpu {
    cores = var.control_node_spec.cores
    type  = "host"
  }

  memory {
    dedicated = var.control_node_spec.memory
  }

  network_device {
    bridge = "vmbr0"
  }

  efi_disk {
    datastore_id = "local-lvm"
    file_format  = "raw"
    type         = "4m"
  }

  # We are going to have 2 disks, boot-disk from local-lvm, and then 
  # another larger disc from iscsi-lvm which is a isci LUN exported 
  # by my TrueNAS server with 2TB of space. This will give the VM's some
  # extra storage for local files. This will need to be configured when setting
  # things up with kubespray's ansible playbooks
  disk {
    datastore_id = "local-lvm"
    file_id      = var.vm_image_id
    interface    = "scsi0"
    file_format  = "raw"
    cache        = "none"
    backup       = "false"
    size         = 25
  }

  # disk {
  #   datastore_id = "lvm-iscsi"
  #   interface    = "scsi1"
  #   file_format  = "raw"
  #   cache        = "none"
  #   backup       = "false"
  #   size         = 50
  # }

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

resource "local_file" "control_ips" {
  content         = join("\n", proxmox_virtual_environment_vm.k8s-worker-large[*].ipv4_addresses[1][0])
  filename        = "output/control_ips.txt"
  file_permission = "0644"
}