resource "null_resource" "copyfiles" {
  provisioner "file" { # File provisioner copies files from the local machine to the remote machine
    source      = "Default.html"
    destination = "/home/linuxadmin/Default.html"

    connection {
      type     = "ssh"
      user     = "linuxadmin"
      password = var.adminpassword
      host     = azurerm_public_ip.appip["appvm01"].ip_address
    }
  }

  provisioner "remote-exec" { # Remote-exec provisioner executes commands on the remote machine
    connection {
      type     = "ssh"
      user     = "linuxadmin"
      password = var.adminpassword
      host     = azurerm_public_ip.appip["appvm01"].ip_address
    }
    inline = ["sudo mv /home/linuxadmin/Default.html /var/www/html/Default.html"]
  }
depends_on = [ azurerm_network_security_group.app_nsg ] # Ensure NSG with SSH access is created before copying files
}

# Can't use file provisioner to copy file to nginx server because privileges are required to write to /var/www/html
# Instead, we use remote-exec to move the file after copying it to a user directory with sudo privileges