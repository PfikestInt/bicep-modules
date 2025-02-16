import * as naming from '../../naming.bicep'

param environment string
param role string
param location string
param counter int
param product string
param addressSpace string
param createdOn string = utcNow('d')

var tags = {
  CreatedOn: createdOn
  Product: product
}

var vnetName = naming.resourceName('vnet', environment, role, location, counter)
resource resolverVnet 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: vnetName
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressSpace
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    privateEndpointVNetPolicies: 'Disabled'
    enableDdosProtection: false
  }
}
