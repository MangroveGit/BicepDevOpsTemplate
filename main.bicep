//GLOBAL VARIABLES
param projectName string
targetScope = 'resourceGroup'
param location string = resourceGroup().location
param resourceGroupName string 

//SA VARIABLES
var storageAccountName = 'sa${projectName}01'
param accountType string = 'Standard_GRS'
param kind string = 'StorageV2'
param accessTier string = 'Hot'
param minimumTlsVersion string = 'TLS1_2'
param supportsHttpsTrafficOnly bool = true
param allowBlobPublicAccess bool = false
param allowSharedKeyAccess bool = true
param networkAclsBypass string = 'AzureServices'
param networkAclsDefaultAction string = 'Allow'
param keySource string = 'Microsoft.Storage'
param encryptionEnabled bool = true
param infrastructureEncryptionEnabled bool = true
param isContainerRestoreEnabled bool = false
param isBlobSoftDeleteEnabled bool = true
param blobSoftDeleteRetentionDays int = 7
param changeFeed bool = false
param isVersioningEnabled bool = false
param isShareSoftDeleteEnabled bool = true
param shareSoftDeleteRetentionDays int = 7

module sa 'Modules/storageaccount.bicep' = {
  scope: resourceGroup('${resourceGroupName}')
  name: 'sa'
  params: {
    location: location
    storageAccountName: storageAccountName
    accountType: accountType
    kind: kind
    accessTier: accessTier
    minimumTlsVersion: minimumTlsVersion
    supportsHttpsTrafficOnly: supportsHttpsTrafficOnly
    allowBlobPublicAccess: allowBlobPublicAccess
    allowSharedKeyAccess: allowSharedKeyAccess
    networkAclsBypass: networkAclsBypass
    networkAclsDefaultAction: networkAclsDefaultAction
    keySource: keySource
    encryptionEnabled: encryptionEnabled
    infrastructureEncryptionEnabled: infrastructureEncryptionEnabled
    isContainerRestoreEnabled: isContainerRestoreEnabled
    isBlobSoftDeleteEnabled: isBlobSoftDeleteEnabled
    blobSoftDeleteRetentionDays: blobSoftDeleteRetentionDays
    changeFeed: changeFeed
    isVersioningEnabled: isVersioningEnabled
    isShareSoftDeleteEnabled: isShareSoftDeleteEnabled
    shareSoftDeleteRetentionDays: shareSoftDeleteRetentionDays
 }
}

//SQL VARIABLES
param sqlservername string = 'sql-${projectName}-01'
param sqldatabasename string = 'sqldb-${projectName}-01'

param sqlsapassword string = 'S3cur3Pa55'
param administratorLogin string = 'sqladmin'
param enableADS bool = true

module sql 'Modules/azuresql.bicep' = {
  scope: resourceGroup('${resourceGroupName}')
  name: 'sql'
  params: {
    location: location
    administratorLogin: administratorLogin
    sqlsapassword: sqlsapassword
    sqlserverName: sqlservername
    enableADS: enableADS
    sqldatabaseName: sqldatabasename
  }
}

