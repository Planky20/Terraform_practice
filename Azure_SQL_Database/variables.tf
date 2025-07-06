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
