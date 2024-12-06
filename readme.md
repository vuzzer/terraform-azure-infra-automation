# Terraform Azure Infrastructure Projects

This repository contains 10 projects demonstrating the use of Terraform to automate and manage various Azure infrastructures. These projects are designed to showcase real-world scenarios and best practices in Infrastructure as Code (IaC).

---

## Table of Contents
1. [Overview](#overview)
2. [Projects](#projects)
3. [Prerequisites](#prerequisites)
4. [How to Use](#how-to-use)
5. [Contributions](#contributions)
6. [License](#license)

---

## Overview
This repository showcases use of Terraform for Azure by automating infrastructure deployment for the following scenarios:
- Web application hosting with App Service Plans.
- Kubernetes cluster setup (AKS).
- Virtual Network configuration with subnets and security groups.
- Load balancers and traffic management.
- Database provisioning (Azure SQL and PostgreSQL).
- Scalable storage solutions using Blob Storage.
- Monitoring and alerting with Azure Monitor.

---

## Projects

| Project Name                    | Description                                                                                     |
|---------------------------------|-------------------------------------------------------------------------------------------------|
| **1. Web App Deployment**       | Deploy a web application with Azure App Service and SQL Database.   [description](./terraform-az-webapp/readme.md)                           |
| **2. Kubernetes on AKS**        | Create a scalable Kubernetes cluster with Azure Kubernetes Service.                            |
| **3. Virtual Network Setup**    | Configure a virtual network with subnets and network security groups (NSGs).                   |
| **4. Load Balancer**            | Set up an Azure Load Balancer to manage traffic for a multi-tier application.                  |
| **5. Database Provisioning**    | Automate the deployment of an Azure SQL database with secure access policies.                  |
| **6. Blob Storage Configuration** | Deploy an Azure Blob Storage account with lifecycle management policies.                       |
| **7. Monitoring and Alerts**    | Set up Azure Monitor with custom metrics and alert rules for infrastructure monitoring.         |
| **8. Disaster Recovery Plan**   | Create a failover strategy using Azure Site Recovery and Backup.                               |
| **9. Azure Functions Setup**    | Deploy a serverless function with triggers and bindings in Azure Functions.                    |
| **10. Cost Management**         | Implement tags and policies to track and optimize Azure resource costs.                        |

---

## Prerequisites
Before running these projects, ensure you have the following:
- **Terraform CLI** (v1.5 or later)
- **Azure CLI** (latest version)
- An **Azure Subscription** with sufficient permissions
- Access to the **Terraform state storage** (Azure Storage Account recommended)
- A valid **service principal** for authentication

---

## How to Use
1. Clone the repository:  

```bash
git clone https://github.com/your-username/terraform-azure-infra-automation.git
```

2. Navigate to the desired project directory:

```bash
cd terraform-azure-infra-automation/<project-name>
```

3. Initialize Terraform:

```bash
Terraform init
```

4. Plan the changes:

```bash
terraform plan
````

5. Apply the configuration

```bash
terraform apply
```

# Contribution

Contributions are welcome! If you want to add new projects or improve existing ones:

1. Fork the repository.

2. Create a feature branch:

```bash
    git checkout -b feature/new-project
```

3. Submit a pull request with a detailed description.


# License

This repository is licensed under the MIT License. See the [LICENSE](./LICENSE) file for more details.