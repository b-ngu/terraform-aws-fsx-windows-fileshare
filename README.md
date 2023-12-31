# terraform-aws-fsx-windows-fileshare

## Summary

Terraform module which creates FSx for Windows File Server resources on AWS.

The main purpose of this module is to provision an FSx for Windows File Server, a fully managed native Microsoft Windows file system built on the AWS cloud. It allows you to move your on-premises active workloads that require file storage to the cloud without any changes or modifications.

## Helpful AWS Documentation Links

- [What is Amazon FSx for Windows File Server?](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/what-is.html)
- [Working with FSx File Systems](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/working-with-fsx.html)
- [FSx with AWS Managed AD Pre-requisites](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/fsx-aws-managed-ad.html)

## Example Usage

```hcl
module "fsx_windows" {
  source = "../../" # Update this with the actual path to your module

  # VPC ID where your resources will be deployed
  vpc_id = "vpc-123abc45"

  # Self-Managed AD Configuration
  self_managed_ad_dns_ips = ["10.0.0.1", "10.0.0.2"]
  self_managed_ad_domain_name = "example.com"
  self_managed_ad_username = "admin"
  self_managed_ad_password = "password" # It's highly recommended to use a secrets manager instead of hardcoding
  self_managed_ad_ou = "OU=YourOU,DC=example,DC=com"

  # FSx Configuration
  automatic_backup_retention_days = 7
  deployment_type = "SINGLE_AZ_1"
  fsx_kms_key = "aws/fsx"
  storage_capacity = 300
  storage_type = "SSD"
  subnet_ids = ["subnet-678fgh56", "subnet-123abc34"] # Replace with your actual subnet IDs
  throughput_capacity = 16


```

Replace `path_to_this_module` with the path to where you have this module.

## FSx Components

1. **File System**: The primary resource representing a virtual file system.
2. **Windows Authentication**: This module assumes you are using `self-managed Active Directory` (different from AWS Managed Microsoft AD) to authenticate and manage your file system users and groups.
3. **Backup**: Automatic daily backups of your file system are taken and retained for 7 days. You can also manually take backups.

## FSx Configuration

This module facilitates the creation and configuration of an FSx for Windows File Server file system, including specifying a VPC, subnets, and KMS key. Once provisioned, it offers a seamless experience for Windows-based applications and workflows.

## Customizing the FSx File Server

This module provides a basic configuration for an FSx for Windows File Server. However, FSx offers various customization options such as storage capacity, throughput capacity, data deduplication, and more. Review the AWS documentation and adjust the module as necessary to fit specific requirements.

## Tags

To configure any additional tags, set tags map in module definition

```hcl

module "fsx_windows" {
  source              = "path_to_this_module"

  ...

  tags = {
    key1        = "value1"
    key2        = "value2"
  }
}

```

## Examples

* [FSx Windows File Server with AWS Managed AD](./examples/fsx)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=4.28 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=4.28 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [data.aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [data.aws_kms_alias.fsx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_alias) | data source |
| [aws_security_group.fsx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_fsx_windows_file_system.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fsx_windows_file_system) | resource |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tags"></a> [tags](#input_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_contact"></a> [contact](#input_contact) | (Required) The contact for this resource. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where this resource will live. | `string` | n/a | yes |
| <a name="input_team"></a> [team](#input_team) | (Required) The team responsible for this resource. | `string` | n/a | yes |
| <a name="input_purpose"></a> [purpose](#input_purpose) | (Required) The purpose for this resource. | `string` | n/a | yes |
| <a name="input_automatic_backup_retention_days"></a> [automatic_backup_retention_days](#input_automatic_backup_retention_days) | The number of days to retain automatic backups. Minimum of 0 and maximum of 90 | `number` | `7` | no |
| <a name="input_deployment_type"></a> [deployment_type](#input_deployment_type) | Specifies the file system deployment type, valid values are MULTI_AZ_1, SINGLE_AZ_1 and SINGLE_AZ_2 | `string` | `SINGLE_AZ_1` | no |
| <a name="input_fsx_kms_key"></a> [fsx_kms_key](#input_fsx_kms_key) | ARN for the KMS Key to encrypt the file system at rest | `string` | `aws/fsx` | no |
| <a name="input_storage_capacity"></a> [storage_capacity](#input_storage_capacity) | Storage capacity (GiB) of the file system. Minimum of 32 and maximum of 65536 | `number` | `32` | no |
| <a name="input_storage_type"></a> [storage_type](#input_storage_type) | Specifies the storage type, valid values are SSD and HDD | `string` | `SSD` | no |
| <a name="input_subnet_ids"></a> [subnet_ids](#input_subnet_ids) | Private subnet ID(s) for the Amazon FSx for Windows | `list(string)` | n/a | yes |
| <a name="input_throughput_capacity"></a> [throughput_capacity](#input_throughput_capacity) | Throughput (megabytes per second) of the file system in power of 2 increments. Minimum of 8 and maximum of 2048 | `number` | `16` | no |
| <a name="input_vpc_id"></a> [vpc_id](#input_vpc_id) | VPC ID for the Amazon FSx for Windows | `string` | n/a | yes |
| <a name="input_self_managed_ad_dns_ips"></a> [self_managed_ad_dns_ips](#input_self_managed_ad_dns_ips) | List of DNS server IP addresses for the self-managed Active Directory | `list(string)` | n/a | yes |
| <a name="input_self_managed_ad_domain_name"></a> [self_managed_ad_domain_name](#input_self_managed_ad_domain_name) | Fully qualified domain name of the self-managed Active Directory | `string` | n/a | yes |
| <a name="input_self_managed_ad_username"></a> [self_managed_ad_username](#input_self_managed_ad_username) | Username for the self-managed Active Directory | `string` | n/a | yes |
| <a name="input_self_managed_ad_password"></a> [self_managed_ad_password](#input_self_managed_ad_password) | Password for the self-managed Active Directory | `string` | n/a | yes |
| <a name="input_self_managed_ad_ou"></a> [self_managed_ad_ou](#input_self_managed_ad_ou) | Organizational unit within the self-managed Active Directory | `string` | `OU=AmazonFSx,DC=YourDomain,DC=com` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fsx_id"></a> [fsx_id](#output_fsx_id) | The ID of the FSx Windows File Server |
| <a name="output_fsx_owner_id"></a> [fsx_owner_id](#output_fsx_owner_id) | AWS account ID that created or owns the FSx Windows File Server |
| <a name="output_fsx_arn"></a> [fsx_arn](#output_fsx_arn) | Amazon Resource Name (ARN) of the FSx Windows File Server |
| <a name="output_fsx_kms_key_id"></a> [fsx_kms_key_id](#output_fsx_kms_key_id) | ARN for the KMS encryption key |
| <a name="output_fsx_dns_name"></a> [fsx_dns_name](#output_fsx_dns_name) | The DNS name for the FSx Windows File Server |
| <a name="output_fsx_preferred_file_server_ip"></a> [fsx_preferred_file_server_ip](#output_fsx_preferred_file_server_ip) | Preferred IP address for mounting the FSx Windows File Server |
| <a name="output_fsx_network_interface_ids"></a> [fsx_network_interface_ids](#output_fsx_network_interface_ids) | ENI IDs associated with the FSx Windows File Server |
| <a name="output_fsx_subnet_ids"></a> [fsx_subnet_ids](#output_fsx_subnet_ids) | Subnet IDs where the File System is located |
| <a name="output_fsx_vpc_id"></a> [fsx_vpc_id](#output_fsx_vpc_id) | VPC ID where the File System is located |

<!-- END_TF_DOCS -->