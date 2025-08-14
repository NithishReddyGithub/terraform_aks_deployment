# Terraform AKS Deployment with Azure Storage Backend

## 📌 Overview
This project provisions an **Azure Kubernetes Service (AKS)** cluster with **Azure Monitor** enabled using Terraform.  
It uses **Azure Storage as a remote backend** to securely store Terraform state files with versioning and locking enabled.

---

## 📂 Project Structure
.
├── backend.tf # Backend configuration for Azure Storage
├── provider.tf # Azure provider setup
├── variables.tf # Input variable definitions
├── terraform.tfvars # Variable values (DO NOT commit to git)
├── outputs.tf # Terraform outputs
├── aks-terraform-script.tf # AKS + Monitoring resources
└── .gitignore # Ignore sensitive/local files


---

## 🛠 Prerequisites
Before running Terraform, ensure you have:

1. **Azure CLI** installed  
   ```bash
   az login
2. Terraform installed (v1.5+ recommended)
3. Free or Paid Azure Subscription
4. Backend Resources (can be created manually in the Azure Portal):
    Resource Group: tfstate-rg
    Storage Account: e.g. tfstatelocking
    Enable Blob Versioning for history
    Enable Soft Delete for recovery
    Storage Container: tfstate

⚙️ Backend Configuration
backend.tf:
terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstatelocking"
    container_name       = "tfstate"
    key                  = "aks/terraform.tfstate"
    use_azuread_auth     = true
  }
}
Note: Backend values must be hardcoded — Terraform does not allow variables here.

🚀 Deployment Steps

Initialize Terraform and configure the backend:
    terraform init -migrate-state

Review the execution plan:
    terraform plan

Apply the changes:
    terraform apply

Access Outputs (like kubeconfig path):
    terraform output

🔐 Security Considerations

Never commit terraform.tfstate or terraform.tfstate.backup to Git.
Add to .gitignore:
*.tfstate
*.tfstate.*
.terraform/
.terraform.lock.hcl
*.tfvars
*.tfvars.json
crash.log

Azure Storage with versioning ensures:
    Locking (no two people apply changes at the same time)
    Version History (you can roll back to previous states)
    Soft Delete (accidental deletions can be recovered)