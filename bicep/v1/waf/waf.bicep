import * as naming from '../../naming.bicep'

param environment string
param role string
param location string
param counter int
param product string
param policySettings object = {
  requestBodyCheck: true
  maxRequestBodySizeInKb: 128
  fileUploadLimitInMb: 100
  state: 'Enabled'
  mode: 'Detection'
  requestBodyInspectLimitInKB: 128
  fileUploadEnforcement: true
  requestBodyEnforcement: true  
}
param managedRules object = {
  managedRuleSets: [
    {
        ruleSetType: 'OWASP'
        ruleSetVersion: '3.2'
        ruleGroupOverrides: []
    }
  ]
  exclusions: []
}
param createdOn string = utcNow('d')

var tags = {
  CreatedOn: createdOn
  Product: product
}

var firewallPolicyName = naming.resourceName('rg', environment, role, location, counter)
resource firewallPolicy 'Microsoft.Network/ApplicationGatewayWebApplicationFirewallPolicies@2024-05-01' = {
  name: firewallPolicyName
  location: location
  tags: tags
  properties: {
    policySettings: policySettings
    managedRules: managedRules
  }
}
