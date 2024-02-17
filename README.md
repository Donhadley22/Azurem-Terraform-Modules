# Provisioning Ubuntu Virtual Machine and Storage Account in Azure with Terraform

This guide explains how to use Terraform to provision an Ubuntu Virtual Machine and a Storage Account in Microsoft Azure.

## Prerequisites

Before you begin, ensure you have the following:

- An active Microsoft Azure subscription
- Terraform installed on your local machine. You can install it from [here](https://learn.hashicorp.com/tutorials/terraform/install-cli).
- Azure CLI installed on your local machine. You can install it from [here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).

## Setup

1. Clone this repository:

   ```bash
   git clone <repository_url>
   cd <repository_directory>
   
## Initialize Terraform 

```bash
terraform init
```

## Configuration
- Open provider.tf file and fill in the required variables such as azure_subscription_id, azure_tenant_id, azure_client_id, azure_client_secret, location, resource_group_name, vm_name, admin_username, admin_password, storage_account_name, and container_name.

- Review and adjust any other settings in main.tf if needed.

## Provisioning Steps
- Authenticate with Azure CLI:
```bash
az login
```
- Set the correct subscription (if you have multiple subscriptions):
```bash
az account set --subscription <subscription_id>
```

- Run Terraform to create the infrastructure:

```bash
terraform apply
```
- Confirm the execution by typing yes when prompted.

## Cleanup
- To avoid incurring charges, make sure to destroy the resources once you're done with them:
```bash
terraform destroy
```
- Confirm the execution by typing yes when prompted.

## Troubleshooting
- If you encounter any issues during provisioning or have questions, feel free to consult the Terraform documentation or Azure documentation. 
Additionally, you can seek help from the Terraform community or Azure support.

## License
This project is licensed under the MIT License.


Make sure to replace `<placeholder>` with actual values or variables from your Terraform configuration files. 
This README provides an overview of how to set up, configure, provision, access, and clean up the resources using Terraform in Azure.

