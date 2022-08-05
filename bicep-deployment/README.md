# Azure Bicep Proof of Concept
- This a PoC for Azure Bicep to create Infrastructure in Azure. We use modules to contain each individual resource for code reuse and readability.

# Creates Azure Resources
This will build the following:
1. Resource Group - built from [Release Pipeline](az-bicep-poc\bicep-deployment\azure-pipelines.yml)
2. [Network Security Group](az-bicep-poc\bicep-deployment\Modules\networkSecurityGroup.bicep)
3. [Private Endpint & Private DNS Zone](az-bicep-poc\bicep-deployment\Modules\privateEndpoint.bicep) 
4. [Storage Account](az-bicep-poc\bicep-deployment\Modules\storageAccount.bicep)
5. [Virtual Network](az-bicep-poc\bicep-deployment\Modules\virtualNetwork.bicep)

# Bicep entry point
- [main.bicep](az-bicep-poc\bicep-deployment\main.bicep) is considered the entry point for the bicep API.

# The Azure-pipeline.yml
- This file is our Multi-stage Release Pipeline. The 2 Stages:
1. Build & Publish Artifact to a Container
2. Deploy the resources that are intialized in each module in the [main.bicep](az-bicep-poc\bicep-deployment\main.bicep)

# Resources
- [Bicep Documentation](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/)

