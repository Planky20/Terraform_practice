variable "app_environment" {
  type = map(object(
    {
      virtualnetworkname      = string
      virtualnetworkcidrblock = string
      subnets = map(object(
        {
          cidrblock = string
      }))
      networkinterfacename = string
      publicipaddressname  = string
      virtualmachinename   = string
    }
  ))
}

variable "adminpassword" {
  type        = string
  description = "Provide the admin password for the VM"
  sensitive   = true
}
