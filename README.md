# Azure IaC Security

**Infrastructure as Code Security | Terraform | Microsoft Azure | Checkov | GitHub Actions**

## Overview

A hands-on Cloud Security and DevSecOps project focused on detecting and remediating Azure infrastructure misconfigurations through Infrastructure as Code (IaC) security scanning.

The project uses Terraform to define Azure resources and Checkov to perform automated security assessments through GitHub Actions.

## Technologies

- Microsoft Azure
- Terraform
- Checkov
- GitHub Actions
- Git and GitHub

## Infrastructure Components

- Azure Resource Group
- Network Security Group (NSG)
- Azure Storage Account

## Implemented Security Controls

- Restricted inbound SSH access
- HTTPS-only storage traffic
- Minimum TLS 1.2
- Disabled public network access for storage
- Disabled anonymous blob access
- Disabled Shared Key authorization
- Storage blob versioning and soft-delete
- Automated security scanning in CI/CD

## Security Testing

An intentionally insecure SSH configuration was introduced in a dedicated test branch.

Checkov detected the vulnerability through policy `CKV_AZURE_10`, causing the GitHub Actions security job to fail.

After remediation, the security scan passed.

This demonstrates automated detection and validation of Infrastructure as Code security changes.

## Latest Security Assessment

**Checkov 3.4.2**

| Result | Count |
|---|---:|
| Passed | 15 |
| Failed | 4 |
| Skipped | 0 |

### Outstanding Findings

| Policy | Finding |
|---|---|
| CKV_AZURE_33 | Queue Storage logging is not configured |
| CKV_AZURE_206 | Storage replication does not satisfy the policy |
| CKV2_AZURE_33 | Private Endpoint is not configured |
| CKV2_AZURE_1 | Customer Managed Key is not configured |

The Storage Account uses ZRS replication, but the replication policy remains unresolved. These findings are retained as documented limitations rather than suppressed.

## Deployment Status

This project was developed and tested locally using Terraform validation and static security scanning.

No Azure resources were deployed as part of the laboratory.

## Author

GitHub: https://github.com/TrabalhoGh