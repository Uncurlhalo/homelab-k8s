resource "proxmox_virtual_environment_vm" "k8s-control-plane" {
  provider  = proxmox.neko
  node_name = var.neko.node_name

  # count of number of control nodes
  count = var.control_node_spec.count

  # Start of actual resrouces for vm
  name          = "k8s-control-${count.index}"
  description   = format("Kubernetes Control Plane %02d", count.index)
  on_boot       = true
  vm_id         = format("90%02d", count.index)

  tags        = ["k8s", "control-plane"]

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
        address = format("192.168.1.2%02d", count.index + 1)
        gateway = "192.168.1.1"
      }
    }
    datastore_id      = "local"
    user_data_file_id = proxmox_virtual_environment_file.cloud-init.id
  }
}

output "control_ipv4_address" {
  depends_on = [proxmox_virtual_environment_vm.k8s-control-plane]
  value      = proxmox_virtual_environment_vm.k8s-control-plane[*].ipv4_addresses[1][0]
}

resource "local_file" "control_plane_ips" {
  content         = join("\n", proxmox_virtual_environment_vm.k8s-control-plane[*].ipv4_addresses[1][0])
  filename        = "output/control_plane_ips.txt"
  file_permission = "0644"
}