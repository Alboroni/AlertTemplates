
resource "azurerm_resource_group" "TFAAlert" {
  name     = "example-resources"
  location = "UK South"
}

resource "azurerm_monitor_action_group" "TFAAlert" {
  name                = "example-actiongroup"
  resource_group_name = azurerm_resource_group.TFAAlert.name
  short_name          = "p0action"

  webhook_receiver {
    name        = "callmyapi"
    service_uri = "http://example.com/alert"
  }
}



resource "azurerm_monitor_activity_log_alert" "TFAAlert" {
  name                = "Route Table Update"
  resource_group_name = azurerm_resource_group.TFAAlert.name
  scopes              = [azurerm_resource_group.TFAAlert.id]
  description         = "This alert will monitor is Route Table has bee created or Update."

  criteria {
    resource_type   = "Microsoft.Network/routeTables"
    operation_name = "Microsoft.Network/routeTables/routes/write"
    category       = "Administrative"
    status = "Succeeded"
  }

  action {
    action_group_id = azurerm_monitor_action_group.TFAAlert.id

    webhook_properties = {
      from = "terraform"
    }
  }
}