#ResourceGroupName=bicep-poc-rg
#location=centralus

# Create a Resource Group
az group create --name bicep-poc-rg --location centralus

# Create a Deployment group - did manual deploy over the Azure CLI in my PoC
az deployment group create --resource-group bicep-poc-rg --template-file main.bicep --parameters storageName=mybicepstoragepoc932

# Deleting a resource Group
az group delete --name bicep-poc-rg
