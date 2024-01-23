output "sql_server_fqdn" {
  value = azurerm_mssql_server.sql_database_server.fully_qualified_domain_name
}

# connection string não existe mais. Não encontrei uma alternativa
# output "database_connection_string" {
#   value = azurerm_mssql_database.azure_database.database_connection_string
# }
