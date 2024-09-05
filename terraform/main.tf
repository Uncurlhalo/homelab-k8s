terraform {
  required_providers {
    proxmox = {
        source = "bpg/proxmox"
        version = "0.63.0"
    }
  }
}

provider "proxmox" {
    alias = "neko"
    endpoint = var.neko.endpoint
    insecure = var.neko.insecure

    api_token = var.neko_auth.api_token
    ssh {
        agent = true
        username = var.neko_auth.username
    }

    tmp_dir = "/var/tmp"
}
