targetScope='subscription'

import * as config from './configuration/sandbox.bicep'
import * as naming from './bicep/naming.bicep'

var resourceGroupName = naming.resourceName('rg', config.naming)
module resourceGroup './bicep/v1/resource-group/resource-group.bicep' = {
  name: resourceGroupName
  params: {
    namingConfig: config.naming
    baseTags: config.tags
    version: config.version
    deployedBy: config.lastDeployedBy
  }
}
