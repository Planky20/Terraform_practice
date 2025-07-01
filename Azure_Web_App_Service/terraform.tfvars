webapp_environment = {
  "production" = {
    serviceplan = {
      serviceplan133795 = {
        sku     = "F1"
        os_type = "Windows"
      }
    }
    serviceapp = {
      webappvlad133795 = "serviceplan133795" # Define the name and reference the service plan
      webappvlad133702 = "serviceplan133795" # Define the name and reference the service plan
    }
  }
}
