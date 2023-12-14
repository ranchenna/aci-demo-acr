resource "azurerm_resource_group" "platform" {
  name     = var.resource_group_name
  location = var.location_name
}

resource "azurerm_container_registry" "platform" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.platform.name
  location            = azurerm_resource_group.platform.location
  sku                 = var.sku
  admin_enabled       = var.admin_enabled

  dynamic "network_rule_set" {
    for_each = var.public_registry ? [1] : []

    content {
      default_action = "Allow"
    }
  }

  tags = {
    environment = "demo-poc"
  }
}

data "azurerm_subnet" "platform" {
    name = var.subnet_name
    resource_group_name = var.subnet_resource_group
    virtual_network_name = var.virtual_network_name 
}

resource "azurerm_private_endpoint" "platform" {
  count               = var.public_registry ? 0 : 1
  name                = var.private_endpoint_name
  resource_group_name = azurerm_resource_group.platform.name
  location            = azurerm_resource_group.platform.location
  subnet_id           = data.azurerm_subnet.platform.id

  private_service_connection {
    name                           = var.private_endpoint_name
    private_connection_resource_id = azurerm_container_registry.platform.id
    is_manual_connection           = false
    subresource_names              = ["registry"]
  }
}
