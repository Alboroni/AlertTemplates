provider "azurerm" {
  version         = ">= 2.0"
  features {}
}

resource "azurerm_resource_group" "AGRG" {
  name     = "terratest"
  location = "UKSouth"
}

resource "azurerm_monitor_metric_alert" "example" {
  name                = "example-multiresource-metricalert"
  resource_group_name =  azurerm_resource_group.AGRG.name
  scopes              = [ "/subscriptions/db99463c-2a00-433c-a39b-f63083b719a4"]
  description         = "Availability below 90"
 target_resource_type = "microsoft.keyvault/vaults"
target_resource_location ="UKSouth"
  criteria {
    metric_namespace = "Microsoft.KeyVault/vaults"
    metric_name      = "Availability"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 95

    
  }

  action {
    action_group_id = "/subscriptions/db99463c-2a00-433c-a39b-f63083b719a4/resourceGroups/ShareServices/providers/microsoft.insights/actiongroups/AlexMail"
  }
}