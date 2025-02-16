import * as naming from '../../naming.bicep'

param environment string
param role string
param location string
param counter int
param product string
param createdOn string = utcNow('d')
param sku object = {
  name: 'Premium'
  tier: 'Premium'
  capacity: 1
}

var tags = {
  CreatedOn: createdOn
  Product: product
}

var serviceBusName = naming.resourceName('sb', environment, role, location, counter)
resource serviceBus 'Microsoft.ServiceBus/namespaces@2024-01-01' = {
  name: serviceBusName
  location: location
  tags: tags
  sku: sku
  properties: {
    publicNetworkAccess: 'Disabled'
  }
}
