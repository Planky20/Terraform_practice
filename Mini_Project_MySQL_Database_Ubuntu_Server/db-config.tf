resource "null_resource" "addfiles" {
  provisioner "file" {
    source      = "01.sql"
    destination = "/home/linuxadmin/01.sql"


    connection {
      type     = "ssh"
      user     = "linuxadmin"
      password = var.adminpassword
      host     = azurerm_public_ip.dbip["dbvm01"].ip_address
    }
  }

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "linuxadmin"
      password = var.adminpassword
      host     = azurerm_public_ip.dbip["dbvm01"].ip_address
    }
    inline = [ "sudo apt update", # Update package lists, required before installing MySQL
               "sudo apt install -y wget lsb-release gnupg", # Install prerequisites for MySQL
               "wget https://dev.mysql.com/get/mysql-apt-config_0.8.29-1_all.deb", # Download MySQL APT config package
               "sudo DEBIAN_FRONTEND=noninteractive dpkg -i mysql-apt-config_0.8.29-1_all.deb", # Install MySQL APT config package
               "sudo apt update", # Update package lists again after adding MySQL repository
               "sudo DEBIAN_FRONTEND=noninteractive apt install -y mysql-server", # Install MySQL server
               "sudo systemctl start mysql", # Start MySQL service
               "sudo mysql -u root < 01.sql", # Injection of SQL file to configure the database
               "sudo sed -i '/^\\[mysqld\\]/a bind-address = VM PRIVATE IP' /etc/mysql/mysql.conf.d/mysqld.cnf", # Configure MySQL to listen on the private IP address
               "sudo systemctl restart mysql"] # Restart MySQL service to apply changes
  }

  depends_on = [azurerm_network_security_group.app_nsg,
  azurerm_linux_virtual_machine.dbvm]
}
