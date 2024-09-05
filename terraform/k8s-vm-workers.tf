# Small workers first
resource "proxmox_virtual_environment_vm" "k8s-worker-small" {
  provider  = proxmox.neko
  node_name = var.neko.node_name

  # count of number of workers
  count = var.worker_node_small_spec.count

  # Start of actual resrouces for vm
  name        = "k8s-worker-small-${count.index}"
  description = format("Kubernetes Small Worker %02d", count.index)
  on_boot     = true
  vm_id       = format("80%02d", count.index)

  machine       = "q35"
  scsi_hardware = "virtio-scsi-pci"
  bios          = "ovmf"

  cpu {
    cores = var.worker_node_small_spec.cores
    type  = "host"
  }

  memory {
    dedicated = var.worker_node_small_spec.memory
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
    file_id      = proxmox_virtual_environment_download_file.debian_12_generic_image.id
    interface    = "scsi0"
    cache        = "none"
    backup       = "false"
    size         = 25
  }

  disk {
    datastore_id = "iscsi-lvm"
    interface    = "scsi1"
    cache        = "none"
    backup       = "false"
    size         = 50
  }

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
        address = format("192.168.1.1%02d", count.index + 1)
        gateway = "192.168.1.1"
      }
    }

    datastore_id      = "local"
    user_data_file_id = proxmox_virtual_environment_file.cloud-init.id
  }
}

# Medium workers next
resource "proxmox_virtual_environment_vm" "k8s-worker-medium" {
  provider  = proxmox.neko
  node_name = var.neko.node_name

  # count of number of workers
  count = var.worker_node_medium_spec.count

  # Start of actual resrouces for vm
  name        = "k8s-worker-medium-${count.index}"
  description = format("Kubernetes Medium Worker %02d", count.index)
  on_boot     = true
  vm_id       = format("81%02d", count.index)

  machine       = "q35"
  scsi_hardware = "virtio-scsi-pci"
  bios          = "ovmf"

  cpu {
    cores = var.worker_node_medium_spec.cores
    type  = "host"
  }

  memory {
    dedicated = var.worker_node_medium_spec.memory
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
    file_id      = proxmox_virtual_environment_download_file.debian_12_generic_image.id
    interface    = "scsi0"
    cache        = "none"
    backup       = "false"
    size         = 25
  }

  disk {
    datastore_id = "iscsi-lvm"
    interface    = "scsi1"
    cache        = "none"
    backup       = "false"
    size         = 50
  }

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
        address = format("192.168.1.1%02d", count.index + 11)
        gateway = "192.168.1.1"
      }
    }

    datastore_id      = "local"
    user_data_file_id = proxmox_virtual_environment_file.cloud-init.id
  }
}

# Large workers last
resource "proxmox_virtual_environment_vm" "k8s-worker-large" {
  provider  = proxmox.neko
  node_name = var.neko.node_name

  # count of number of workers
  count = var.worker_node_large_spec.count

  # Start of actual resrouces for vm
  name        = "k8s-worker-large-${count.index}"
  description = format("Kubernetes Large Worker %02d", count.index)
  on_boot     = true
  vm_id       = format("82%02d", count.index)

  machine       = "q35"
  scsi_hardware = "virtio-scsi-pci"
  bios          = "ovmf"

  cpu {
    cores = var.worker_node_large_spec.cores
    type  = "host"
  }

  memory {
    dedicated = var.worker_node_large_spec.memory
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
    file_id      = proxmox_virtual_environment_download_file.debian_12_generic_image.id
    interface    = "scsi0"
    cache        = "none"
    backup       = "false"
    size         = 25
  }

  disk {
    datastore_id = "iscsi-lvm"
    interface    = "scsi1"
    cache        = "none"
    backup       = "false"
    size         = 50
  }

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
        address = format("192.168.1.1%02d", count.index + 21)
        gateway = "192.168.1.1"
      }
    }

    datastore_id      = "local"
    user_data_file_id = proxmox_virtual_environment_file.cloud-init.id
  }
}

# Consolidate outputs and files
output "worker_small_ipv4_address" {
  depends_on = [proxmox_virtual_environment_vm.k8s-worker-small]
  value      = proxmox_virtual_environment_vm.k8s-worker-small[*].ipv4_addresses[1][0]
}

resource "local_file" "worker_small_ips" {
  content         = join("\n", proxmox_virtual_environment_vm.k8s-worker-small[*].ipv4_addresses[1][0])
  filename        = "output/worker_small_ips.txt"
  file_permission = "0644"
}

output "worker_medium_ipv4_address" {
  depends_on = [proxmox_virtual_environment_vm.k8s-worker-medium]
  value      = proxmox_virtual_environment_vm.k8s-worker-medium[*].ipv4_addresses[1][0]
}

resource "local_file" "worker_medium_ips" {
  content         = join("\n", proxmox_virtual_environment_vm.k8s-worker-medium[*].ipv4_addresses[1][0])
  filename        = "output/worker_medium_ips.txt"
  file_permission = "0644"
}

output "worker_large_ipv4_address" {
  depends_on = [proxmox_virtual_environment_vm.k8s-worker-large]
  value      = proxmox_virtual_environment_vm.k8s-worker-large[*].ipv4_addresses[1][0]
}

resource "local_file" "worker_large_ips" {
  content         = join("\n", proxmox_virtual_environment_vm.k8s-worker-large[*].ipv4_addresses[1][0])
  filename        = "output/worker_large_ips.txt"
  file_permission = "0644"
}
