# Dynamics house all the CIDR and other dynamic elements of this module

variable "base_cidr" {}

locals {
  _kops_reserved = "${cidrsubnet(var.base_cidr, 1, 0)}"
  _ops_based     = "${cidrsubnet(var.base_cidr, 1, 1)}"

  public_cidr_subnets = [
    "${cidrsubnet(local._ops_based, 4, 0)}",
    "${cidrsubnet(local._ops_based, 4, 1)}",
    "${cidrsubnet(local._ops_based, 4, 2)}",
    "${cidrsubnet(local._ops_based, 4, 3)}",
  ]

  private_cidr_subnets = [
    "${cidrsubnet(local._ops_based, 4, 4)}",
    "${cidrsubnet(local._ops_based, 4, 5)}",
    "${cidrsubnet(local._ops_based, 4, 6)}",
    "${cidrsubnet(local._ops_based, 4, 7)}",
  ]

  admin_cidr_subnets = [
    "${cidrsubnet(local._ops_based, 4, 8)}",
    "${cidrsubnet(local._ops_based, 4, 9)}",
    "${cidrsubnet(local._ops_based, 4, 10)}",
    "${cidrsubnet(local._ops_based, 4, 11)}",
  ]

  kops_subnets = {
    node_cidr_1    = "${cidrsubnet(local._kops_reserved, 3, 0)}"
    node_cidr_2    = "${cidrsubnet(local._kops_reserved, 3, 1)}"
    node_cidr_3    = "${cidrsubnet(local._kops_reserved, 3, 2)}"
    node_cidr_4    = "${cidrsubnet(local._kops_reserved, 3, 3)}"
    utility_cidr_1 = "${cidrsubnet(local._kops_reserved, 3, 4)}"
    utility_cidr_2 = "${cidrsubnet(local._kops_reserved, 3, 5)}"
    utility_cidr_3 = "${cidrsubnet(local._kops_reserved, 3, 6)}"
    utility_cidr_4 = "${cidrsubnet(local._kops_reserved, 3, 7)}"
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
