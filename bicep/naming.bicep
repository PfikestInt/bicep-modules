@description('Formats parameters in the form of the naming convention.')
@export()
func resourceName(resourceType string, naming object) string => naming.location == 'eastus' ? '${resourceType}-${naming.environment}-${naming.role}-${padLeft(naming.counter, 3, '0')}' : '${toLower(resourceType)}-${toLower(naming.environment)}-${toLower(naming.role)}-${toLower(naming.location)}-${padLeft(naming.counter, 3, '0')}'
