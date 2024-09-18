terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc4"
    }
  }
}

provider "proxmox" {
  alias           = "neko"
  pm_api_url      = var.neko.pm_api_url
  pm_tls_insecure = var.neko.pm_tls_insecure

  pm_api_token_id     = var.neko_auth.pm_api_token_id
  pm_api_token_secret = var.neko_auth.pm_api_token_secret

  #pm_log_enable = true
  #pm_log_file   = "terraform-plugin-proxmox.log"
  #pm_debug      = true
  #pm_log_levels = {
  #  _default    = "debug"
  #  _capturelog = ""
  #}
}