variable "dbapp_environment" {
  type = map(object(
    {
      server = map(object(
        {
          databases = map(object(
            {
              sku      = string
              sampledb = string # Sample database is a pre-built database with sample data that can be used for testing, development, or learning purposes
            }
          ))
        }
      ))
    }
  ))
}

variable "app_setup" {
  type = list(string)
}

variable "webapp_environment" {
  type = map(object(
    {
      serviceplan = map(object(
        {
          sku     = string
          os_type = string
        }
      ))
      serviceapp = map(string)
    }
  ))
}
