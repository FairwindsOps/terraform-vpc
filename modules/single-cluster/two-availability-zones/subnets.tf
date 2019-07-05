# Dynamics house all the CIDR and other dynamic elements of this module

variable "base_cidr" {}

locals {
  _kops_reserved = "${cidrsubnet(var.base_cidr, 1, 0)}"
  _ops_based     = "${cidrsubnet(var.base_cidr, 1, 1)}"

  public_cidr_subnets = [
    "${cidrsubnet(local._ops_based, 3, 0)}",
    "${cidrsubnet(local._ops_based, 3, 1)}",
  ]

  private_cidr_subnets = [
    "${cidrsubnet(local._ops_based, 3, 2)}",
    "${cidrsubnet(local._ops_based, 3, 3)}",
  ]

  admin_cidr_subnets = [
    "${cidrsubnet(local._ops_based, 3, 4)}",
    "${cidrsubnet(local._ops_based, 3, 5)}",
  ]

  kops_subnets = {
    node_cidr_1    = "${cidrsubnet(local._kops_reserved, 2, 0)}"
    node_cidr_2    = "${cidrsubnet(local._kops_reserved, 2, 1)}"
    utility_cidr_1 = "${cidrsubnet(local._kops_reserved, 2, 2)}"
    utility_cidr_2 = "${cidrsubnet(local._kops_reserved, 2, 3)}"
  }
}

output "entire_network" {
  value = "${var.base_cidr}"
}

output "supernets" {
  value = {
    OpsNetwork  = "${local._ops_based}"
    KopsNetwork = "${local._kops_reserved}"
  }
}

output "public_cidrs" {
  value = ["${local.public_cidr_subnets}"]
}

output "private_cidrs" {
  value = ["${local.private_cidr_subnets}"]
}

output "admin_cidrs" {
  value = ["${local.admin_cidr_subnets}"]
}

output "kops_cidrs" {
  value = "${local.kops_subnets}"
}
