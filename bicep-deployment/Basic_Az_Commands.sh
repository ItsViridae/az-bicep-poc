# Create a Resource Group
az group create --name bicepRG --location centralus

# Create a Deployment group - did manual deploy over the Azure CLI in my PoC
az deployment group create --resource-group bicepRG --template-file main.bicep --parameters storageName=mybicepstoragepoc932

# Deleting a resource Group
az group delete --name bicepRG
