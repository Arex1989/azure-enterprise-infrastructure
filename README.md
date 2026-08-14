# Azure Enterprise Infrastructure

## Project Overview

This project demonstrates the design and implementation of a secure and supportable Microsoft Azure infrastructure environment for a fictional organization.

The project is being developed as a hands-on cloud engineering lab to demonstrate practical experience across cloud infrastructure, networking, identity, security, monitoring, automation and Infrastructure as Code.

## Business Scenario

A growing organization requires a secure Azure environment to host business workloads.

The infrastructure must provide:

- Segmented cloud networking
- Secure access to workloads
- Identity and role-based access control
- Windows and Linux compute resources
- Cloud storage
- Infrastructure monitoring and alerting
- Backup and recovery
- Repeatable infrastructure deployment

## Technologies

This project will progressively use:

- Microsoft Azure
- Microsoft Entra ID
- Azure Virtual Network
- Network Security Groups
- Azure Virtual Machines
- Azure Storage
- Azure Monitor
- Log Analytics
- Azure Backup
- PowerShell
- Terraform
- Git and GitHub

## Project Status

🟡 In Progress

### Completed

- Created a dedicated Azure subscription for the lab environment
- Configured a monthly Azure cost budget with 50%, 75% and 90% actual-cost alerts
- Selected UK South as the primary deployment region
- Established an enterprise-style resource naming convention
- Created the development resource group `rg-azure-enterprise-dev`
- Implemented resource tagging for environment, project, purpose and management method

### Current Phase

Azure networking and network segmentation.

## Resource Organisation

The project uses the following Azure resource organisation:

| Resource | Name | Purpose |
|---|---|---|
| Subscription | Azure subscription 1 | Billing and resource management boundary |
| Resource Group | rg-azure-enterprise-dev | Logical container for development infrastructure |
| Primary Region | UK South | Primary deployment region |

### Resource Tags

| Tag | Value |
|---|---|
| Environment | Development |
| Project | AzureEnterpriseLab |
| Purpose | CloudEngineeringPortfolio |
| ManagedBy | Manual |

The environment is currently being deployed manually through the Azure Portal to develop practical understanding of each Azure component before recreating the infrastructure using Terraform.

## Planned Project Phases

1. Architecture and requirements
2. Azure subscription and cost controls
3. Resource organization
4. Virtual network and subnet design
5. Network security
6. Compute deployment
7. Identity and RBAC
8. Storage
9. Monitoring and logging
10. Backup and recovery
11. Infrastructure testing
12. Terraform Infrastructure as Code
13. Final architecture documentation

## Learning Objectives

Through this project I aim to develop and demonstrate practical capability in:

- Designing Azure infrastructure
- Implementing secure cloud networking
- Applying least-privilege access principles
- Deploying and managing cloud compute resources
- Monitoring infrastructure health and performance
- Planning backup and recovery
- Automating infrastructure deployment
- Using Terraform for Infrastructure as Code
- Documenting technical architecture and engineering decisions
