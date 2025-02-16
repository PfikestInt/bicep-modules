targetScope='subscription'

import * as naming from '../../naming.bicep'

param namingConfig object
param baseTags object
param lastDeployment string = utcNow('d')
param version string
param deployedBy string

var tags = union(
  baseTags,
  {
    'Last Deployment': lastDeployment
    'Last Deployed By': deployedBy
    Version: version
  }
)

var resourceGroupName = naming.resourceName('rg', namingConfig)
resource resourceGroup 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  name: resourceGroupName
  location: namingConfig.location
  tags: tags
}

var initiatives = [
  {
    name: 'CIS Azure Foundations v2.1.0'
    id: '/providers/Microsoft.Authorization/policySetDefinitions/fe7782e4-6ff3-4e39-8d8a-64b6f7b82c85'
  }
]
resource policyAssignments 'Microsoft.Authorization/policyAssignments@2025-01-01' = [
  for initiative in initiatives: {
    name: initiative.name 
    location: namingConfig.location
    properties: {
      displayName: initiative.name
      policyDefinitionId: initiative.id
      parameters: {
        'operationName-c5447c04-a4d7-4ba8-a263-c9ee321a6858': {value: 'Microsoft.Authorization/policyAssignments/write'}
        'operationName-b954148f-4c11-4c38-8221-be76711e194a': {value: 'Microsoft.Sql/servers/firewallRules/write'}
      }
    } 
  }
]
