# Requirements

- [AWS Account](https://console.aws.amazon.com/)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- [Terraform >=0.12](https://www.terraform.io/downloads.html)
- [Kubernetes CLI](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

# Credentials

## Create Credentials

1. Sign in to the AWS Management Console and open the IAM console at https://console.aws.amazon.com/iam/.

2. In the navigation pane, choose Users.

3. Choose the name of the user whose access keys you want to create, and then choose the Security credentials tab.

4. In the Access keys section, choose Create access key.

5. To view the new access key pair, choose Show. You will not have access to the secret access key again after this dialog box closes. Your credentials will look something like this:

⋅⋅⋅ Access key ID: AKIAIOSFODNN7EXAMPLE  
⋅⋅⋅ Secret access key: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY

## Use Files

```
$ aws configure
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name [None]: ca-central-1
Default output format [None]: json
```

Credentials will be stored in this directory:

```
~/.aws
```

## Use Environment Variables

```
export AWS_ACCESS_KEY_ID="AKIAIOSFODNN7EXAMPLE"
export AWS_SECRET_ACCESS_KEY="wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
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
aws eks update-kubeconfig --name "$(terraform output cluster_name)" --kubeconfig "${KUBECONFIG}"
```

## Try kubectl

```
kubectl get pods -A
```

## Cleanup

```
terraform destroy
```

# Resources

- [Terraform AWS Provider](https://www.terraform.io/docs/providers/aws/index.html)
