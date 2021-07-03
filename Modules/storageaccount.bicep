param location string 
param storageAccountName string 
param accountType string 
param kind string 
param accessTier string 
param minimumTlsVersion string 
param supportsHttpsTrafficOnly bool 
param allowBlobPublicAccess bool 
param allowSharedKeyAccess bool 
param networkAclsBypass string 
param networkAclsDefaultAction string 
param keySource string 
param encryptionEnabled bool 
param infrastructureEncryptionEnabled bool 
param isContainerRestoreEnabled bool 
param isBlobSoftDeleteEnabled bool 
param blobSoftDeleteRetentionDays int 
param changeFeed bool 
param isVersioningEnabled bool 
param isShareSoftDeleteEnabled bool 
param shareSoftDeleteRetentionDays int 

resource storageAccountName_resource 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAccountName
  location: location
  properties: {
    accessTier: accessTier
    minimumTlsVersion: minimumTlsVersion
    supportsHttpsTrafficOnly: supportsHttpsTrafficOnly
    allowBlobPublicAccess: allowBlobPublicAccess
    allowSharedKeyAccess: allowSharedKeyAccess
    networkAcls: {
      bypass: networkAclsBypass
      defaultAction: networkAclsDefaultAction
      ipRules: []
    }
    encryption: {
      keySource: keySource
      services: {
        blob: {
          enabled: encryptionEnabled
        }
        file: {
          enabled: encryptionEnabled
        }
        queue: {
          enabled: encryptionEnabled
        }
        table: {
          enabled: encryptionEnabled
        }
      }
      requireInfrastructureEncryption: infrastructureEncryptionEnabled
    }
  }
  sku: {
    name: accountType
  }
  kind: kind
  tags: {}
  dependsOn: []
}

resource storageAccountName_default 'Microsoft.Storage/storageAccounts/blobServices@2019-06-01' = {
  parent: storageAccountName_resource
  name: 'default'
  properties: {
    restorePolicy: {
      enabled: isContainerRestoreEnabled
    }
    deleteRetentionPolicy: {
      enabled: isBlobSoftDeleteEnabled
      days: blobSoftDeleteRetentionDays
    }
    changeFeed: {
      enabled: changeFeed
    }
    isVersioningEnabled: isVersioningEnabled
  }
}

resource Microsoft_Storage_storageAccounts_fileservices_storageAccountName_default 'Microsoft.Storage/storageAccounts/fileservices@2019-06-01' = {
  parent: storageAccountName_resource
  name: 'default'
  properties: {
    shareDeleteRetentionPolicy: {
      enabled: isShareSoftDeleteEnabled
      days: shareSoftDeleteRetentionDays
    }
  }
  dependsOn: [
    storageAccountName_default
  ]
}

resource storageAccountName_default_datalake 'Microsoft.Storage/storageAccounts/blobServices/containers@2018-07-01' = {
  name: '${storageAccountName}/default/datalake'
  dependsOn: [
    storageAccountName_resource
  ]
}

resource storageAccountName_default_downloads 'Microsoft.Storage/storageAccounts/blobServices/containers@2018-07-01' = {
  name: '${storageAccountName}/default/downloads'
  dependsOn: [
    storageAccountName_resource
  ]
}

resource storageAccountName_default_backups 'Microsoft.Storage/storageAccounts/blobServices/containers@2018-07-01' = {
  name: '${storageAccountName}/default/backups'
  dependsOn: [
    storageAccountName_resource
  ]
}

output outsaId string = storageAccountName_resource.id
