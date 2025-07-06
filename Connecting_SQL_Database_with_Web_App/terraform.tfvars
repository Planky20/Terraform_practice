dbapp_environment = {
  production = {
    server = {
      sqlserverwl0607 = {
        databases = {
          appdb = {
            sku      = "S0"
            sampledb = null # Sample database is a pre-built database with sample data that can be used for testing, development, or learning purposes
          }
          adventureworksdb = {
            sku      = "S0"
            sampledb = "AdventureWorksLT" # Sample database is a pre-built database with sample data that can be used for testing, development, or learning purposes
          }
        }
      }
    }
  }
}

app_setup = ["sqlserverwl0607", "appdb"] # This is a list of applications to be set up, where each application is represented by its server name and database name.

webapp_environment = {
  production = {
    serviceplan = {
      serviceplanwl0607 = {
        sku     = "B1"
        os_type = "Windows"
      }
    }
    serviceapp = {
      webappwl0607 = "serviceplanwl0607"
    }
  }
}
