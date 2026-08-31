# Phase 11 – Infrastructure Testing

## Azure Enterprise Infrastructure Lab

This document records the infrastructure validation performed after deployment of the Azure Enterprise Infrastructure Lab.

The objective of this phase was to verify that the deployed networking, compute, identity, storage, monitoring, backup, update management, and security components operate as intended.

---

## Test Summary

| Test | Validation Area | Result |
|---|---|---|
| Test 1 | Infrastructure Baseline | PASS |
| Test 2 | Network & Subnet Configuration | PASS |
| Test 3 | NAT Gateway / Outbound Connectivity | PASS |
| Test 4 | Network Security | PASS |
| Test 5 | Monitoring & Logging | PASS |
| Test 6 | Identity & RBAC | PASS |
| Test 7 | Backup & Recovery | PASS |
| Test 8 | Update Management | PASS |
| Test 9 | Security Posture | PASS |

**Overall Result: PASS**

---

# Test 1 – Infrastructure Baseline Validation

## Objective

Verify that the core Azure infrastructure resources were successfully deployed and available in the development resource group.

## Components Validated

- Azure Resource Group
- Virtual Network
- Subnets
- Network Security Groups
- Linux Virtual Machine
- Storage Account
- Log Analytics Workspace
- Recovery Services Vault
- Azure Monitor components

## Result

PASS

The expected infrastructure components were successfully deployed within the Azure environment and were available for subsequent validation.

---

# Test 2 – Network and Subnet Validation

## Objective

Verify the logical network segmentation implemented within the Azure Virtual Network.

## Network Architecture

Virtual Network:

`vnet-enterprise-dev`

Address space:

`10.10.0.0/16`

Subnets:

- Web subnet – `10.10.1.0/24`
- Application subnet – `10.10.2.0/24`
- Management subnet – `10.10.3.0/24`

## Validation

The subnet architecture was reviewed to confirm that workloads could be separated according to their intended function.

Network Security Groups were associated with the appropriate subnets to provide traffic filtering and segmentation.

## Result

PASS

The network architecture and subnet segmentation matched the intended enterprise design.

---

# Test 3 – NAT Gateway and Outbound Connectivity

## Objective

Validate controlled outbound Internet connectivity for workloads hosted within the application subnet.

## Components

- NAT Gateway
- Static Public IP
- Application subnet
- Linux application VM

## Validation

The application subnet was associated with the configured Azure NAT Gateway.

Outbound connectivity was verified using the NAT Gateway public IP architecture.

The application workload therefore does not require a directly assigned public IP address for outbound Internet communication.

## Result

PASS

Controlled outbound connectivity through the NAT Gateway was successfully validated.

---

# Test 4 – Network Security Validation

## Objective

Verify that Network Security Groups enforce the intended network access controls.

## Components

- Web NSG
- Application NSG
- Management NSG
- HTTPS security rule
- Subnet-to-NSG associations

## Validation

Network Security Group associations were reviewed and validated.

The web security configuration includes controlled HTTPS access using TCP port 443.

Subnet-level security boundaries were verified to ensure that network traffic is governed by the appropriate NSG.

## Result

PASS

Network security controls were correctly associated with their respective network segments.

---

# Test 5 – Monitoring and Logging Validation

## Objective

Verify centralized monitoring and logging capabilities.

## Components

- Azure Log Analytics Workspace
- Azure Monitor
- Azure Monitor Agent
- Data Collection Rules
- Action Group
- Scheduled Query Alert

## Monitoring Workspace

`law-azure-enterprise-dev`

## Alert

`alert-blob-failures-dev`

The scheduled query alert monitors Azure Blob Storage operations and detects relevant HTTP failure responses including:

- HTTP 401
- HTTP 403
- HTTP 5xx

The alert evaluates Storage Blob logs and is connected to the configured Azure Monitor Action Group.

## Result

PASS

Monitoring, logging, alerting, and notification infrastructure were successfully validated.

---

# Test 6 – Identity and RBAC Validation

## Objective

Validate identity-based access controls used within the Azure environment.

## Validation Areas

- Microsoft Entra ID
- Azure RBAC
- Managed Identity
- Storage access permissions
- Resource authorization

Azure RBAC was used to control access to cloud resources rather than relying exclusively on shared credentials.

Managed identity capabilities were incorporated into the infrastructure design to support identity-based service authentication.

## Result

PASS

Identity and authorization controls were successfully validated.

---

# Test 7 – Backup and Recovery Validation

## Objective

Verify that recovery capabilities exist for protected infrastructure workloads.

## Components

- Azure Recovery Services Vault
- VM backup configuration
- Recovery infrastructure

The Recovery Services Vault was verified as part of the deployed infrastructure.

Backup and recovery configuration provides protection against accidental deletion, corruption, or infrastructure failure.

## Result

PASS

Backup and recovery capabilities were successfully validated.

---

# Test 8 – Update Management Validation

## Objective

Validate operating-system update and patch-management visibility for the deployed compute workload.

## Components

- Azure Update Management
- Linux Virtual Machine
- Patch/update assessment

The VM update configuration was reviewed to confirm visibility into operating-system update status and patch compliance.

This provides an operational mechanism for maintaining workload security and reliability.

## Result

PASS

Update-management capabilities were successfully validated.

---

# Test 9 – Security Posture Validation

## Objective

Review the overall security posture of the Azure environment.

## Security Controls Reviewed

- Network segmentation
- Network Security Groups
- TLS enforcement
- Storage public-access restrictions
- Azure RBAC
- Managed identities
- Monitoring
- Backup protection
- Logging
- Alerting
- Infrastructure tagging

The environment uses multiple layers of security rather than relying on a single control.

This follows a defense-in-depth approach across networking, identity, data protection, monitoring, and recovery.

## Result

PASS

The implemented infrastructure security controls were successfully validated.

---

# Terraform Drift Validation

Infrastructure state was also compared against the Terraform configuration.

Terraform validation was performed using:

```bash
terraform fmt
terraform validate
terraform plan
```

The final Terraform plan returned:

```text
No changes. Your infrastructure matches the configuration.
```

This confirms that the Terraform-managed resources match the deployed Azure infrastructure.

---

# Phase 11 Result

**Phase 11 – Infrastructure Testing: COMPLETE**

Nine infrastructure validation tests were completed covering:

- Networking
- Network security
- Compute
- Identity
- RBAC
- Storage
- Monitoring
- Logging
- Alerting
- Backup and recovery
- Update management
- Security posture
- Terraform drift detection

The Azure Enterprise Infrastructure Lab successfully passed the infrastructure validation phase and is ready to proceed to:

**Phase 12 – Terraform Infrastructure as Code**
