# Terraform code for build AWS infra for microsvc app

- modules: TF modules for defining the AWS services used in infra
- prod: Instances of modules for building prod environment: values set at terraform.tfvars and defined at variables.tf 

Below the architecture:


![Architecture](https://github.com/andrescueva/microsvc/blob/main/images/architecture.png)



## Pipelines
- CI - microsvc-infra/.github/workflows/ci.yml: runs terraform init, terraform validate, terraform plan.
- CD - microsvc-infra/.github/workflows/ci.yml: manual execution of terraform apply.

## Repository secrets

- AWS_ACCESS_KEY_ID: AWS_ACCESS_KEY_ID of the account with permissions to create services in the target env
- AWS_SECRET_ACCESS_KEY: AWS_SECRET_ACCESS_KEY  of the account with permissions to create services in the target env

## Repository variables
- AWS_REGION: region of the environment
