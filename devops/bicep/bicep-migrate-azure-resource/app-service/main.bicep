param appServicePlanSkuName string = 'F1'
param appServicePlanSkuTier string = 'Free'

var sitesName = 'webapp0001'
var serverfarmName = 'asp-mslearn'
var location = resourceGroup().location
var tags = {
  owner: 'webteam'
}

resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: serverfarmName
  location: location
  tags: {
    owner: 'webteam'
  }
  sku: {
    name: appServicePlanSkuName
    tier: appServicePlanSkuTier
    capacity: 1
  }
  kind: 'linux'
}

resource appServiceApp 'Microsoft.Web/sites@2024-04-01' = {
  name: sitesName
  location: location
  tags: tags
  kind: 'app,linux'
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: '${sitesName}-ekbdfkcbb9f6cuef.eastasia-01.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: '${sitesName}-ekbdfkcbb9f6cuef.scm.eastasia-01.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    serverFarmId: appServicePlan.id
  }
}

resource appServiceAppConfig 'Microsoft.Web/sites/config@2024-04-01' = {
  parent: appServiceApp
  name: 'web'
  properties: {
    numberOfWorkers: 1
    netFrameworkVersion: 'v4.0'
    linuxFxVersion: 'DOTNETCORE|9.0'
    alwaysOn: false
  }
}

resource appServiceHosting 'Microsoft.Web/sites/hostNameBindings@2024-04-01' = {
  parent: appServiceApp
  name: '${sitesName}-ekbdfkcbb9f6cuef.eastasia-01.azurewebsites.net'
  properties: {
    siteName: 'webapp0001'
    hostNameType: 'Verified'
  }
}
