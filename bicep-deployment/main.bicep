param resourcePrefix string = 'bicep'
param virtualNetworkPrefix string = '10.123.0.0/16'
param vmUsername string = 'azuretest'
param currentDate string = utcNow('yyyy-MM-dd')

var subnetname = '${resourcePrefix}-sn'
var tagValues = {
  CreatedBy: 'BICEPDeployment'
  deploymentDate: currentDate
}

module sta 'Modules/storageAccount.bicep' = {
  name: 'sta'
  params: {
    storageAccountPrefix: resourcePrefix
    tagValues: tagValues
  }
}

module nsg 'Modules/networkSecurityGroup.bicep' = {
  name: 'nsg'
  params: {
    ResourcePrefix: resourcePrefix
    tagValues: tagValues
    securityRules: []
  }
}

module vnet 'Modules/virtualNetwork.bicep' = {
  name: 'vnet'
  params: {
    ResourcePrefix: resourcePrefix
    virtualNetworkPrefix: virtualNetworkPrefix
    tagValues: tagValues
    subnets: [
      {
        name: subnetname
        virtualNetworkPrefix: replace(virtualNetworkPrefix, '0.0/16', '1.0/24')
        privateEndpointNetworkPolicies: 'Disabled'
        privateLinkServiceNetworkPolicies: 'Disabled'
        nsg: nsg.outputs.nsgid
      }
    ]
  }
}

module privateEndPoint 'Modules/privateEndpoint.bicep' = {
  name: 'privateEndPoint'
  params: {
    tagValues: tagValues
    privateEndpointName: '${resourcePrefix}-pep'
    storageAccountId: sta.outputs.staid
    vnetId: vnet.outputs.vnetid
    subnetName: subnetname
  }
}

/* Creates VM, Public IP, and Network Interface */
/* Later, modify using resourcePrefix and VnetPrefixes*/
module vm 'Modules/virtualMachine.bicep' = {
  name: 'vm'
  params: {
    /*test instance - mock user and pass for VM*/
    adminUsername: vmUsername
    adminPassword: 'Azuretest123!'
    tagValues: tagValues
    VnetName: vnet.outputs.vnetname
    SubnetName: subnetname
  }
}
