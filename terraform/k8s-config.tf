# Creat our cloud-init.yml localy and then upload it in a null_resource (probably not the best solution)
resource "local_file" "cloud_init_config" {
  content = templatefile("./cloud-init/k8s-user-data.yml.tftpl", {
    username = var.vm_user
    password = var.vm_password
    pub-key  = var.host_public_key
  })
  filename = "${path.module}/cloud-init/k8s-user-data.yml"
}

resource "null_resource" "cloud_init_config_upload" {
  connection {
    type     = "ssh"
    host     = var.neko.hostname
    user     = var.neko_auth.pm_user
    password = var.neko_auth.pm_password
  }

  provisioner "file" {
    source      = local_file.cloud_init_config.filename
    destination = "/var/lib/vz/snippets/k8s-user-data.yml"
  }
}