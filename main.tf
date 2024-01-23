resource "azurerm_resource_group" "database" {
  name     = "database-resource-group"
  location = "East US"
}

resource "azurerm_storage_account" "azure_storage" {
  name                     = "storage"
  resource_group_name      = azurerm_resource_group.database.name
  location                 = azurerm_resource_group.database.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_mssql_server" "sql_database_server" {
  name                         = "database-sql-server"
  resource_group_name          = azurerm_resource_group.database.name
  location                     = azurerm_resource_group.database.location
  version                      = "12.0"
  administrator_login          = "admin_azure_sql_database_login"
  administrator_login_password = "admin_azure_sql_database_password"
  tags = {
    environment = "dev"
  }
}

resource "azurerm_mssql_database" "azure_database" {
  name                = "azure-sql-database"
  server_id           = azurerm_mssql_server.sql_database_server.id
  collation           = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb         = 1
  read_scale          = true
  sku_name            = "S0"
  zone_redundant      = false
  enclave_type        = "VBS"

  lifecycle {
    prevent_destroy = true
  }
}

# Checar a criação de regras de firewall
# resource "azurerm_sql_firewall_rule" "example" {
#   name                = "allow external ip"
#   resource_group_name = azurerm_resource_group.database.name
#   server_name         = azurerm_mssql_server.sql_database_sever.name
#   start_ip_address    = var.start_ip
#   end_ip_address      = var.end_ip
# }