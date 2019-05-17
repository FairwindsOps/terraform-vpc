# Dynamics house all the CIDR and other dynamic elements of this module

locals {
  _supernet_one   = "${cidrsubnet(var.vpc_cidr, 2, 0)}"
  _supernet_two   = "${cidrsubnet(var.vpc_cidr, 2, 1)}"
  _supernet_three = "${cidrsubnet(var.vpc_cidr, 2, 2)}"
  _supernet_four  = "${cidrsubnet(var.vpc_cidr, 2, 3)}"

  public_cidr_subnets = [
    "${cidrsubnet(local._supernet_one, 2, 0)}",
    "${cidrsubnet(local._supernet_one, 2, 1)}",
    "${cidrsubnet(local._supernet_one, 2, 2)}",
  ]

  private_cidr_subnets = [
    "${cidrsubnet(local._supernet_one, 2, 3)}",
    "${cidrsubnet(local._supernet_two, 2, 0)}",
    "${cidrsubnet(local._supernet_two, 2, 1)}",
  ]

  admin_cidr_subnets = [
    "${cidrsubnet(local._supernet_two, 2, 2)}",
    "${cidrsubnet(local._supernet_two, 2, 3)}",
    "${cidrsubnet(local._supernet_three, 2, 0)}",
  ]

  kops_subnets = {
    node_cidr_one      = "${cidrsubnet(local._supernet_three, 2, 1)}"
    node_cidr_two      = "${cidrsubnet(local._supernet_three, 2, 2)}"
    node_cidr_three    = "${cidrsubnet(local._supernet_three, 2, 3)}"
    utility_cidr_one   = "${cidrsubnet(local._supernet_four, 2, 0)}"
    utility_cidr_two   = "${cidrsubnet(local._supernet_four, 2, 1)}"
    utility_cidr_three = "${cidrsubnet(local._supernet_four, 2, 2)}"
  }
}

output "supernets" {
  value = [
    "${local._supernet_one}",
    "${local._supernet_two}",
    "${local._supernet_three}",
    "${local._supernet_four}",
  ]
}
