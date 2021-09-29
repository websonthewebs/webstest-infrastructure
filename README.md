# edde-platform-deployment

[![CircleCI](https://circleci.com/gh/greyshore/edde-platform-deployment/tree/main.svg?style=svg&circle-token=85775bb783716e1b8d8d47d865bd315d1079b80e)](https://circleci.com/gh/greyshore/edde-platform-deployment/tree/main)

This repo is used as a "seed" repo for the management of a delivery platform for the EDDE product. The intention is for this repo to be a template/seed that can be used by a scaffolding program to spin up a delivery platform specific to a cohort of students. Each cohort would have a unique copy of this repo and unique resources would be deployed from those repos.

# prerequisites
- Terraform
- terraform-compliance
- CircleCI

# customization
The pipeline in this repo can be customized to deploy different EDDE environments by changing the following in .circleci/config.yml

line 7-9: 
  static_web_storage_account_name:
    type: string
    default: "<< the unique name of the web storage account for the cohort environment >>"
line 10-12:
  resource_group_name:
    type: string
    default: "<< the name of the Azure Resource Group for the cohort environment >>"
line 13-15:
  backend_container_name:
    type: string
    default: "<< container name used for hosting the static web content for the cohort application >>"
line 25-28:
    environment:
      ARM_CLIENT_ID: << client ID of service principal with the permissions to manage resources within the cohort environment >>
      ARM_SUBSCRIPTION_ID: << parent subscription ID that will host the cohort environment resources  >>
      ARM_TENANT_ID: << the parent Azure AD tenant ID for the overall cohort environment resources >>

# terraform files
The terraform files are currently broken out into separate files defining the following groups of resources:
- backend.tf - defines the location of the terraform remote state 
- main.tf - defines the provider and current context settings
- resource_groups.tf - defines the creation of the parent resource groups
- storage.tf - defines the storage account resources and any output token data
- terraform.tfvars - defines any custom configuration specific to the resources managed in this pipeline
- variables.tf - defines the variable structure and descriptive definitions of their use

# circleci api key for context creation
There is a GS pipeline service account called "svc-gs-pipeline". Its email address and mailbox are hosted on Ionos and its email address is "svc_gs_pipeline@paulsoftware.com".
This information, along with the circleci api key for the service account are vaulted in the AKV-DE-Keyvault in Azure.
<br>
<br>
This service account is used for the following:
- CircleCI access in order to create and manage contexts.