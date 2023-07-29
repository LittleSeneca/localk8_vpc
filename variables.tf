variable "vault_url" {
  type = string
}
data "vault_generic_secret" "api_token" {
  path = "proxmox/terraform"
}
variable "pm_target_node" {
  type    = string
  default = "virthost0"
}
variable "pm_target_storage" {
  type    = string
  default = "storage"
}
variable "vm_tags_controller" {
  type    = list(string)
  default = ["lx k8-primary", "lx k8-member", "lx k8-member", "lx k8-member"]
}
variable "vm_tags_workers" {
  type    = string
  default = "lx k8-worker"
}
variable "vault_token" {
  type = string
}
variable "pm_template_name" {
  type = string
  default = "centos9-template"
}
variable "pm_cloud_user" {
  type = string
  default = "pve-user"
}
variable "pm_cloud_search" {
  type = string
  default = "lan.littleseneca.com"
}
