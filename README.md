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

- Created a Standard LRS Azure Storage Account in UK South for enterprise application data
- Restricted storage network access to approved networks using the `Microsoft.Storage` service endpoint on `snet-app`
- Configured temporary client-IP access for controlled administrative testing without exposing the storage account to all public networks
- Implemented Microsoft Entra ID authorization and assigned `Storage Blob Data Contributor` RBAC permissions for authenticated data-plane access
- Disabled anonymous Blob access and enforced secure transfer with TLS 1.2
- Implemented 7-day soft-delete protection for blobs and containers and enabled Blob Versioning
- Validated Blob Versioning by overwriting a test configuration object and successfully accessing the retained previous version
- Validated Soft Delete by deliberately deleting and successfully recovering a protected Blob object

### Current Phase
Microsoft Entra ID, Azure RBAC and identity-based access control.

> **Compute deployment note:** Azure Virtual Machine deployment was evaluated using free-services-eligible B-series SKUs. VM deployment is currently restricted by subscription-level regional/SKU availability. Compute implementation has therefore been deferred while the remaining infrastructure, security, monitoring and Infrastructure as Code components are developed.

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

## Network Architecture

The Azure environment uses a segmented virtual network to separate
workloads based on their function and security requirements.

### Network Security Design

| Network Security Group | Associated Subnet | Security Purpose |
| ---------------------- | ----------------- | ---------------- |
| nsg-web-dev | snet-web | Controls inbound and outbound traffic for web-tier workloads |
| nsg-app-dev | snet-app | Protects application-tier workloads from unnecessary direct access |
| nsg-management-dev | snet-management | Provides a dedicated security boundary for administrative workloads |

The web-tier NSG currently permits inbound HTTPS traffic over TCP port 443 using a custom priority 100 rule.

Application and management tiers are not directly exposed through custom Internet-facing inbound rules. Additional access will be introduced only where required by the workload architecture, following least-privilege principles.

### Virtual Network

| Component | Configuration |
|---|---|
| VNet | vnet-enterprise-dev |
| Address Space | 10.10.0.0/16 |
| Region | UK South |
| Resource Group | rg-azure-enterprise-dev |

### Subnet Design

| Subnet | Address Range | Purpose |
|---|---|---|
| snet-web | 10.10.1.0/24 | Web-facing workloads |
| snet-app | 10.10.2.0/24 | Application workloads |
| snet-management | 10.10.3.0/24 | Administrative and management workloads |

The /16 VNet provides sufficient address capacity for future expansion,
while dedicated /24 subnets provide logical workload segmentation.

The segmented network is protected using dedicated Network Security Groups (NSGs) for the web, application and management tiers. Custom traffic rules are introduced only where required by the workload architecture, following least-privilege principles.

## Storage Architecture

The environment includes an Azure Storage Account for secure application and business data storage.

### Storage Configuration

| Component | Configuration |
| --- | --- |
| Storage Account | stazureenterprisedev |
| Primary Service | Azure Blob Storage |
| Region | UK South |
| Performance | Standard |
| Redundancy | Locally Redundant Storage (LRS) |
| Access Tier | Hot |
| Blob Container | enterprise-data |
| Anonymous Access | Disabled |
| Minimum TLS | TLS 1.2 |
| Encryption | Microsoft-managed keys |

### Network Security

Storage network access is restricted to selected networks rather than being exposed to all public networks.

The `snet-app` subnet is authorised through a `Microsoft.Storage` service endpoint, allowing application-tier workloads to access the storage service through the approved Azure network path.

Temporary client-IP access was introduced for controlled administrative testing without changing the storage account to unrestricted public network access.

### Identity and Access Control

Microsoft Entra ID is used as the default authorization method for Azure Storage administration.

The `Storage Blob Data Contributor` Azure RBAC role was assigned to provide authenticated data-plane permissions for Blob operations without relying on storage account keys for routine access.

This demonstrated the distinction between:

- Azure management-plane permissions
- Storage data-plane permissions
- Network-level access controls

### Data Protection

The following data-protection controls were implemented:

- Blob soft delete with a 7-day retention period
- Container soft delete with a 7-day retention period
- Blob Versioning
- Encryption at rest using Microsoft-managed keys
- Secure transfer for data in transit

### Validation Testing

Blob Versioning was validated by uploading an initial configuration object, modifying the object, and uploading the updated version under the same name. Azure retained the previous version and allowed it to be accessed through version history.

Soft Delete was validated by deliberately deleting the test Blob and successfully recovering it during the configured retention period.

These tests confirmed that the configured controls provide protection against both accidental modification and accidental deletion.

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
