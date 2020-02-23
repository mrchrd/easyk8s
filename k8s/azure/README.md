# Requirements

- [Azure Account](https://portal.azure.com/)
- [Azure CLI >=2.0.68](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
- [jq](https://stedolan.github.io/jq/download/)
- [Terraform >=0.12](https://www.terraform.io/downloads.html)
- [Kubernetes CLI](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

# Credentials

## Create Service Principal

```
az login

az account list
#[
#  {
#    "cloudName": "AzureCloud",
#    "id": "00000000-0000-0000-0000-000000000000",       <-- ARM_SUBSCRIPTION_ID
#    "isDefault": true,
#    "name": "PAYG Subscription",
#    "state": "Enabled",
#    "tenantId": "00000000-0000-0000-0000-000000000000", <-- ARM_TENANT_ID
#    "user": {
#      "name": "user@example.com",
#      "type": "user"
#    }
#  }
#]

ARM_SUBSCRIPTION_ID=`az account list --query '[0].id' -o tsv`
ARM_TENANT_ID=`az account list --query '[0].tenantId' -o tsv`

az ad sp create-for-rbac --role Owner | tee ./account.json
#{
#  "appId": "00000000-0000-0000-0000-000000000000",      <-- ARM_CLIENT_ID
#  "displayName": "azure-cli-2017-06-05-10-41-15",
#  "name": "http://azure-cli-2017-06-05-10-41-15",
#  "password": "0000-0000-0000-0000-000000000000",       <-- ARM_CLIENT_SECRET
#  "tenant": "00000000-0000-0000-0000-000000000000"
#}

ARM_CLIENT_ID=`jq -r .appId ./account.json`
ARM_CLIENT_SECRET=`jq -r .password ./account.json`

az ad app permission add --id "${ARM_CLIENT_ID}" --api "00000002-0000-0000-c000-000000000000" --api-permissions "1cda74f2-2616-4834-b122-5cb1b07f8a59=Role" "78c8a3c8-a07e-4b9e-af1b-b5ccab50a175=Role"
az ad app permission grant --id "${ARM_CLIENT_ID}" --api "00000002-0000-0000-c000-000000000000" --expires never
az ad app permission admin-consent --id "${ARM_CLIENT_ID}"
```

## Use Environment Variables

```
export ARM_CLIENT_ID="00000000-0000-0000-0000-000000000000"
export ARM_CLIENT_SECRET="00000000-0000-0000-0000-000000000000"
export ARM_SUBSCRIPTION_ID="00000000-0000-0000-0000-000000000000"
export ARM_TENANT_ID="00000000-0000-0000-0000-000000000000"
```

# Usage

## Cluster Creation

```
terraform init
terraform apply
```

## Get kubeconfig

```
export KUBECONFIG="${PWD}/kubeconfig"
terraform output kubeconfig > "${KUBECONFIG}"
```

or

```
export KUBECONFIG="${PWD}/kubeconfig"
az aks get-credentials --resource-group "$(terraform output resource_group)" -n "$(terraform output cluster_name)" -a -f "${KUBECONFIG}"
```

## Try kubectl

```
kubectl get pods -A
```

## Cleanup

```
terraform destroy
az ad app delete --id "${ARM_CLIENT_ID}"
```

# Resources

- [Terraform Azure Provider](https://www.terraform.io/docs/providers/azurerm/index.html)
- [Terraform Azure Active Directory Provider](https://www.terraform.io/docs/providers/azuread/index.html)
