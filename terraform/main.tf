terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.64.0"
    }
    pihole = {
      source = "ryanwholey/pihole"
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

provider "pihole" {
  url       = var.pihole_url
  api_token = var.pihole_api_token

}