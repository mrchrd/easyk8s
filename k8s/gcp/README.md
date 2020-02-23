# Requirements

- [Google Cloud Account](https://console.cloud.google.com/)
- [Google Cloud CLI](https://cloud.google.com/sdk/docs#install_the_latest_cloud_tools_version_cloudsdk_current_version)
- [Terraform >=0.12](https://www.terraform.io/downloads.html)
- [Kubernetes CLI](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

# Credentials

## Create Project and Service Account

```
GOOGLE_CREDENTIALS='./account.json'
GOOGLE_PROJECT_NAME='codecafe1'
GOOGLE_SA='codecafe1'

gcloud auth login

gcloud projects create "${GOOGLE_PROJECT_NAME}" --enable-cloud-apis
gcloud projects list --filter "name=${GOOGLE_PROJECT_NAME}" --format json
#[
#  {
#    "createTime": "2020-02-22T20:01:19.855Z",
#    "lifecycleState": "ACTIVE",
#    "name": "example",
#    "parent": {
#      "id": "000000000000",
#      "type": "organization"
#    },
#    "projectId": "example-123",                      <-- GOOGLE_PROJECT
#    "projectNumber": "000000000000"
#  }
#]

GOOGLE_PROJECT=`gcloud projects list --filter "name=${GOOGLE_PROJECT_NAME}" --format 'value(projectId)'`

gcloud beta billing accounts list --filter 'open=true' --format json
#[
#  {
#    "displayName": "My Billing Account",
#    "name": "billingAccounts/000000-000000-000000",  <-- GOOGLE_BA
#    "open": true
#  }
#]

GOOGLE_BA=`gcloud beta billing accounts list --filter 'open=true' --format 'value(name)'`

gcloud beta billing projects link "${GOOGLE_PROJECT}" --billing-account "${GOOGLE_BA}"

gcloud --project "${GOOGLE_PROJECT}" iam service-accounts create "${GOOGLE_SA}"
gcloud --project "${GOOGLE_PROJECT}" iam service-accounts keys create --iam-account "${GOOGLE_SA}@${GOOGLE_PROJECT}.iam.gserviceaccount.com" "${GOOGLE_CREDENTIALS}"

gcloud projects add-iam-policy-binding "${GOOGLE_PROJECT}" --member "serviceAccount:${GOOGLE_SA}@${GOOGLE_PROJECT}.iam.gserviceaccount.com" --role='roles/owner'

```

## Use Files and Environment Variables

Credentials will be stored in this file:

```
account.json
```

```
export GOOGLE_CREDENTIALS="./account.json"
export GOOGLE_PROJECT="example-123"
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
gcloud container clusters get-credentials --project "$(terraform output project)" --region "$(terraform output location)" "$(terraform output cluster_name)"

```

## Try kubectl

```
kubectl get pods -A
```

## Cleanup

```
terraform destroy
gcloud projects delete "${GOOGLE_PROJECT}"
```

# Resources

- [Terraform Google Provider](https://www.terraform.io/docs/providers/google/index.html)
