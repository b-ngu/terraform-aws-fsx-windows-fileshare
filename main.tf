data "aws_vpc" "vpc" {
  id = var.vpc_id
}

data "aws_kms_alias" "fsx" {
  name = "alias/${var.fsx_kms_key}"
}

resource "aws_security_group" "fsx" {
  name        = "${local.resource_prefix}-fsx-sg.${var.self_managed_ad_domain_name}"
  description = "${local.resource_prefix}-fsx-sg ${var.self_managed_ad_domain_name}"

  dynamic "ingress" {
    for_each = local.fsx_ports
    iterator = fsx_ports
    content {
      description = fsx_ports.value.description
      from_port   = fsx_ports.value.from_port
      to_port     = fsx_ports.value.to_port
      protocol    = fsx_ports.value.protocol
      cidr_blocks = [fsx_ports.value.cidr_blocks]
    }
  }

  egress {
    description = "Outbound to everywhere"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(
    { "Name" = "${local.resource_prefix}-fsx-sg.${var.self_managed_ad_domain_name}"},
    var.tags,
  )
  vpc_id = var.vpc_id
}

resource "aws_fsx_windows_file_system" "main" {

  self_managed_active_directory {
    dns_ips           = var.self_managed_ad_dns_ips
    domain_name       = var.self_managed_ad_domain_name
    username          = var.self_managed_ad_username
    password          = var.self_managed_ad_password
    organizational_unit_distinguished_name = var.self_managed_ad_ou
  }

  aliases                         = ["${local.resource_prefix}.${var.self_managed_ad_domain_name}"]
  automatic_backup_retention_days = var.automatic_backup_retention_days
  deployment_type                 = var.deployment_type
  kms_key_id                      = data.aws_kms_alias.fsx.arn
  preferred_subnet_id             = var.subnet_ids[0]
  security_group_ids              = [aws_security_group.fsx.id]
  skip_final_backup               = true
  storage_capacity                = var.storage_capacity
  storage_type                    = var.storage_type
  subnet_ids                      = var.subnet_ids
  tags = {
    Name = "${local.resource_prefix}-fsx.${var.self_managed_ad_domain_name}"
  }
  throughput_capacity = var.throughput_capacity
}