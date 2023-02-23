# Terraform code for build AWS infra for microsvc app

modules: TF modules for defining the AWS services used in infra
prod: Instances of modules for building prod environment

Below the architecture:


![Architecture](https://github.com/andrescueva/microsvc/blob/main/images/architecture.png)



## Pipelines
- CI - microsvc-infra/.github/workflows/ci.yml: runs terraform init, terraform validate, terraform plan.
- CD - microsvc-infra/.github/workflows/ci.yml: manual execution of terraform apply.

## Repository secrets

- AWS_ACCESS_KEY_ID: AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY: AWS_SECRET_ACCESS_KEY

## Repository variables
- AWS_REGION: region of the environment
