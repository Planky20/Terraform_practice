webapp_environment = {
  "production" = {
    serviceplan = {
      serviceplan133795 = {
        sku     = "S1" # Need to have S1 or higher for slots
        os_type = "Windows"
      }
    }
    serviceapp = {
      webappvlad133795 = "serviceplan133795" # Define the name and reference the service plan
      webappvlad133702 = "serviceplan133795" # Define the name and reference the service plan
    }
  }
}

resource_tags = {
  "tags" = {
    department = "Logistics"
    tier       = "Tier2"
  }
}

webapp_slot = ["webappvlad133795", "staging"]
