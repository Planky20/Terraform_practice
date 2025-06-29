variable "app_environment" {
  type = map(object(
    {
      virtualnetworkname      = string
      virtualnetworkcidrblock = string
      subnets = map(object(
        {
          cidrblock = string
          machines = map(object(
            {
              networkinterfacename = string
              publicipaddressname  = string
            }
          ))
      }))
    }
  ))
}


variable "adminpassword" {
  type = string
  description = "This is the admin password for the VM"
  sensitive = true
}