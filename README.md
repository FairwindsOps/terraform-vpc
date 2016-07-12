# terraform-vpc

A Terraform module to create and manage ReactiveOps VPC architectures.

Based on https://github.com/cloudfoundry-community/terraform-aws-cf-install

## Private Subnet NAT: EC2 Instances vs. NAT Gateways

This module supports either NAT instances or gateways for private subnets in the VPC. This option is selectable by setting one of two variable flags to `1`.

Since Terraform has no concept of conditionals for resources this value is used as a count multiplier to zero out resources associated with the disabled option.

** Don't set either of these values to 100 unless you want 300 instances/gateways. **

```
# NAT routing via EC2 instances
nat_instance_enabled = 1
nat_gateway_enabled = 0
```

```
# NAT routing via NAT gateways
nat_instance_enabled = 0
nat_gateway_enabled = 1
```

## Usage

* Required variables:

```
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_key_name" {}
variable "aws_region" {}

variable "aws_azs" {}
variable "az_count" {}

variable "vpc_cidr_base" {}
variable "org_name" {}

variable "nat_instance_enabled" {}
variable "nat_gateway_enabled" {}
```

* Example variables:

```
aws_key_name = "nat"
aws_azs = "us-west-2a, us-west-2b, us-west-2c, us-west-2d"
az_count = 3
nat_instance_enabled = 0
nat_gateway_enabled = 1
vpc_cidr_base = "10.0"
org_name = "reactr"
```

* Include this in your main.tf:

```
module "vpc" {
  source = "./modules/terraform-vpc"
  org_name = "${var.org_name}"

  aws_access_key = "${var.aws_access_key}"
  aws_secret_key = "${var.aws_secret_key}"
  aws_region = "${var.aws_region}"

  az_count =  "${var.az_count}"
  aws_azs = "${var.aws_azs}"

  vpc_cidr_base = "${var.vpc_cidr_base}"

  nat_instance_enabled = "${var.nat_instance_enabled}"
  nat_gateway_enabled = "${var.nat_gateway_enabled}"

  nat_key_name = "${var.nat_key_name}"
  nat_instance_type = "${var.nat_instance_type}"
}
```
