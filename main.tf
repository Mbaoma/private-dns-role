data "azurerm_subscription" "primary" {}

# Resource group
resource "azurerm_resource_group" "dns_rg" {
  name     = var.dns_rg_name
  location = var.location
}

# Define the role
resource "azurerm_role_definition" "private_dns_zone_manage" {
  name        = var.role_name
  scope       = data.azurerm_subscription.primary.id
  description = var.description

  permissions {
    actions = [
      "Microsoft.Network/privateDnsZones/read",
      "Microsoft.Network/privateDnsZones/write",
    #   "Microsoft.Network/privateDnsZones/dnsRecordSets/read",
    #   "Microsoft.Network/privateDnsZones/dnsRecordSets/write"
      // You can add more actions as needed
    ]
  }

  assignable_scopes = [
    data.azurerm_subscription.primary.id
  ]
}

#Assign the role to the user
resource "azurerm_user_assigned_identity" "dns_user_id" {
  resource_group_name = azurerm_resource_group.dns_rg.name
  location            = var.location
  name                = var.user_assigned_id_name
}

resource "azurerm_role_assignment" "dns_role_assignment" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = azurerm_role_definition.private_dns_zone_manage.name
  principal_id         = azurerm_user_assigned_identity.dns_user_id.principal_id
}