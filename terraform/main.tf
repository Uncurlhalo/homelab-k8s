terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.64.0"
    }
  }
}

provider "proxmox" {
  alias     = "neko"
  endpoint  = var.pve.endpoint
  api_token = var.pve_auth.api_token
  insecure  = var.pve.insecure

  ssh {
    agent    = true
    username = var.pve_auth.username
  }

  tmp_dir = "/var/tmp"
}