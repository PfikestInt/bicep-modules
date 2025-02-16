import * as naming from '../../naming.bicep'

param nameConfig object
param tags object
param product string
param gatewayIPConfigurations array
param frontendIPConfigurations array
param frontendPorts array
param backendAddressPools array
param backendHttpSettingsCollection array
param httpListeners array
param requestRoutingRules array
param sku object = {
  name: 'WAF_v2'
  tier: 'WAF_v2'
  family: 'Generation_1'
  capacity: 2
}

var vnetName = naming.resourceName('agw', nameConfig)
resource applicationGateway 'Microsoft.Network/applicationGateways@2024-05-01' = {
  name: vnetName
  location: nameConfig.location
  tags: tags
  properties: {
    sku: sku
    gatewayIPConfigurations: gatewayIPConfigurations
    frontendIPConfigurations: frontendIPConfigurations
    frontendPorts: frontendPorts
    backendAddressPools: backendAddressPools
    backendHttpSettingsCollection: backendHttpSettingsCollection
    httpListeners: httpListeners
    requestRoutingRules: requestRoutingRules
  }
}
