terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.9.10"
    }
  }
}
provider "proxmox" {
  pm_api_url = "${data.vault_generic_secret.api_token.data["api_url"]}/api2/json"
  pm_api_token_id = data.vault_generic_secret.api_token.data["api_token_id"]
  pm_api_token_secret = data.vault_generic_secret.api_token.data["api_token_secret"]
  pm_tls_insecure = true
  pm_parallel = 20
}
provider "vault" {
  address = var.vault_url
  token   = var.vault_token
  skip_tls_verify = true
}