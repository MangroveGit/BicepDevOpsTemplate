param administratorLogin string
@secure()
param sqlsapassword string
param location string
param sqlserverName string
param enableADS bool = true
param sqldatabaseName string


resource serverName_resource 'Microsoft.Sql/servers@2019-06-01-preview' = {
  name: sqlserverName
  location: location
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: sqlsapassword
    version: '12.0'
  }
}

resource sqlServerName_database 'Microsoft.Sql/servers/databases@2017-03-01-preview' = {
  parent: serverName_resource
  location: location
  name: sqldatabaseName
  properties: {}
}

resource serverName_Default 'Microsoft.Sql/servers/securityAlertPolicies@2017-03-01-preview' = if (enableADS) {
  parent: serverName_resource
  name: 'Default'
  properties: {
    state: 'Enabled'
    emailAccountAdmins: true
  }
}

output outsqlserverId string = serverName_resource.id
