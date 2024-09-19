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
  endpoint  = var.neko.endpoint
  api_token = var.neko_auth.api_token
  insecure  = var.neko.insecure

  ssh {
    agent    = true
    username = var.neko_auth.username
  }

  tmp_dir = "/var/tmp"
}