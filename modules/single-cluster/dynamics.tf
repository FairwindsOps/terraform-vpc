# Dynamics house all the CIDR and other dynamic elements of this module

locals {
  public_cidr_subnets  = var.public_subnets_list
  private_cidr_subnets = var.private_subnets_list
  admin_cidr_subnets   = var.admin_subnets_list
}
