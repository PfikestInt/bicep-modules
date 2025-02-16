param managedIdentityName string
param tags object

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: managedIdentityName
  location: resourceGroup().location
  tags: tags
}

var managedIdendityContributorId = '/subscriptions/46b82283-ba32-4501-a19e-7b75892faf7f/providers/Microsoft.Authorization/roleDefinitions/e40ec5ca-96e0-45a2-b4ff-59039f2c2b59'
resource managedIdendityContributor 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(resourceGroup().id, managedIdendityContributorId)
  scope: resourceGroup()
  properties: {
    roleDefinitionId: managedIdendityContributorId
    principalId: managedIdentity.properties.principalId
    principalType: 'ServicePrincipal'
  }
}

var userAccessAdministratorId = '/subscriptions/46b82283-ba32-4501-a19e-7b75892faf7f/providers/Microsoft.Authorization/roleDefinitions/18d7d88d-d35e-4fb5-a5c3-7773c20a72d9'
resource userAccessAdministrator 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(resourceGroup().id, userAccessAdministratorId)
  scope: resourceGroup()
  properties: {
    roleDefinitionId: userAccessAdministratorId
    principalId: managedIdentity.properties.principalId
    principalType: 'ServicePrincipal'
  }
}

var resourcePolicyContributorId = '/subscriptions/46b82283-ba32-4501-a19e-7b75892faf7f/providers/Microsoft.Authorization/roleDefinitions/36243c78-bf99-498c-9df9-86d9f8d28608'
resource resourcePolicyContributor 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(resourceGroup().id, resourcePolicyContributorId)
  scope: resourceGroup()
  properties: {
    roleDefinitionId: resourcePolicyContributorId
    principalId: managedIdentity.properties.principalId
    principalType: 'ServicePrincipal'
  }
}
