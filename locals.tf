locals {

  contact     = var.contact
  environment = var.environment
  team        = var.team
  purpose     = var.purpose

  resource_prefix = "${local.team}-${local.environment}-${local.purpose}"

  fsx_ports = [
    {
      from_port   = 445
      to_port     = 445
      description = "SMB"
      protocol    = "TCP"
      cidr_blocks = data.aws_vpc.vpc.cidr_block
    },
    {
      from_port   = 5985
      to_port     = 5986
      description = "WinRM"
      protocol    = "TCP"
      cidr_blocks = data.aws_vpc.vpc.cidr_block
    }
  ]
}