provider "azurerm" {
  features {}
}

module "resource_group" {
  source = "git::https://github.com/opsstation/terraform-azure-resource-group.git?ref=v1.0.0"

  name        = "app-log-analy"
  environment = "test"
  label_order = ["name", "environment"]
  location    = "Canada Central"
}

module "log-analytics" {
  source                           = "../."
  name                             = "app"
  environment                      = "test"
  resource_group_name              = module.resource_group.resource_group_name
  log_analytics_workspace_location = module.resource_group.resource_group_location

  #### diagnostic setting
  log_analytics_workspace_id = module.log-analytics.workspace_id
}
