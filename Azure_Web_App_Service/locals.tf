locals {
  resource_location = "West Europe"
  production_tags = {
    production_code = "${var.resource_tags.tags.department}-${var.resource_tags.tags.tier}"
    production_tier = "${var.resource_tags.tags.tier}"
  }
}