targetScope = 'subscription'

param sshPublicKey string
param resourceGroupName string = 'supatil-test'
param location string = 'westus3'
param isNewDeployment bool = true
var adminUsername string = 'ubuntu'

var shellScript = loadTextContent('init-script.sh')

// Create resource group for Jenkins infrastructure
resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: location
}

// Deploy infrastructure to the resource group
module infrastructure 'infrastructure.bicep' = {
  name: 'jenkinsInfrastructure'
  scope: rg
  params: {
    location: location
    adminUsername: adminUsername
    sshPublicKey: sshPublicKey
    shellScript: shellScript
    isNewDeployment: isNewDeployment
  }
}
