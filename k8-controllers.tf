resource "proxmox_vm_qemu" "k8-controller" {
  count             = 4
  name              = "k8-controller${count.index}.lan.littleseneca.com"
  target_node       = var.pm_target_node
  clone             = var.pm_template_name
  full_clone        = false
  os_type           = "cloud-init"
  cores             = 8
  sockets           = "1"
  cpu               = "host"
  memory            = 8192
  scsihw            = "virtio-scsi-pci"
  bootdisk          = "scsi0"
  agent             = 1
  tags              = element(var.vm_tags_controller, count.index)
  disk {
    size            = "100G"
    type            = "scsi"
    storage         = var.pm_target_storage
  }
  network {
    model           = "virtio"
    bridge          = "vmbr0"
  }
  lifecycle {
    ignore_changes  = [
      network,
    ]
  }
  # Cloud Init Settings
  nameserver = "192.168.8.8"
  ciuser = var.pm_cloud_user
  sshkeys = <<EOF
${file("~/.ssh/id_rsa.pub")}
EOF
}