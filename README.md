# AKS Deployment Process with Terraform

This document explains the step-by-step process of deploying an **Azure Kubernetes Service (AKS)** cluster with **Azure Monitor enabled** using Terraform.  

---

## Prerequisites
- An active **Azure subscription** (Free Trial or Paid).  
- **Terraform** installed locally (v1.0+).  
- **Azure CLI** (`az`) installed and authenticated.  
  ```sh
  az login
  az account set --subscription "<your-subscription-id>"
  ```

  ---
  
# AKS Deployment Steps

## 1. Clone or Create Terraform Project
Create a directory and add Terraform files:
- `main.tf` → Contains AKS resource definitions.  
- `variables.tf` → Contains input variables.  
- `terraform.tfvars` → Holds values for variables.  
- `outputs.tf` → Defines cluster output values.  
- `provider.tf` → Provider and backend configuration.  

---

## 2. Backend Configuration (Azure Storage)
We use **Azure Storage Account** for Terraform state storage to enable locking, security, and versioning.  

### Steps:
1. Create a **Resource Group** in Azure Portal.  
2. Create a **Storage Account** (Standard LRS is sufficient).  
3. Create a **Blob Container** (e.g., `tfstate`).  
4. Configure `backend.tf`:  
   ```hcl
   terraform {
     backend "azurerm" {
       resource_group_name  = "tfstate-rg"
       storage_account_name = "tfstate<unique>"
       container_name       = "tfstate"
       key                  = "aks/terraform.tfstate"
       use_azuread_auth     = true
     }
   }
   ```

---

## 3. Initialize Terraform
Run the following command:
```sh
terraform init
```
This initializes the provider and backend state.

---

## 4. Validate & Plan
Check for errors and see what resources will be created:
```sh
terraform validate
terraform plan -out aks.plan
```

---

## 5. Apply Deployment
Execute the plan to provision AKS:
```sh
terraform apply "aks.plan"
```

---

## 6. Connect to AKS

Once deployment is successful:

```sh
az aks get-credentials --resource-group <rg-name> --name <aks-cluster-name>
```

Verify connection:

```sh
kubectl get nodes
```

---

## 7. Security Considerations

- Add
`*.tfstate
*.tfstate.*
.terraform/
.terraform.lock.hcl
*.tfvars
*.tfvars.json
crash.log`
to `.gitignore`.

 ---

## 8. Outputs

Terraform will print outputs such as:

- Cluster Name  
- Resource Group  
- Kubernetes Config Path  
