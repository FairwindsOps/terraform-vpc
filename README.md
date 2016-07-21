# Amazon Web Services VPC Terraform Module

This Terraform module creates a configurable general purpose Amazon Web Services VPC. The module offers an opinionated but flexible network topography geared towards general purpose situations with public and private subnets. Each VPC can be configured to support single or multiple availability zones. Private subnet NAT'ing can be configured via either EC2 appliance instances or NAT Gateways. The module does not configure a bastion or VPN instance for private subnet instance access.

## Example VPC Layout: 3 AZ's

![Example VPC: 3AZ](https://dl.dropboxusercontent.com/s/eayeua10o00dqkx/example-vpc-3AZ.png)

## Usage

* Include the module in your `main.tf`:

```
module "vpc" {
  source = "https://github.com/reactiveops/terraform-vpc.git"

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

* Create the required variables either in `main.tf` or a separate `variables.tf` file:

```
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_key_name" {}
variable "aws_region" {}

variable "aws_azs" {}
variable "az_count" {}

variable "vpc_cidr_base" {}

variable "nat_instance_enabled" {}
variable "nat_gateway_enabled" {}
```

* Assign variable values, for example in a `terraform.tfvars` file:

```
aws_key_name = "nat"
aws_azs = "us-west-2a, us-west-2b, us-west-2c, us-west-2d"
az_count = 3
nat_instance_enabled = 0
nat_gateway_enabled = 1
vpc_cidr_base = "10.0"
```

This repo contains several example `*.tfvars.examples` files for example variable configurations.

## Configuration Options

### VPC IP CIDR

Your VPC will be a /16 CIDR. Choose the IP range you want by setting the `vpc_cidr_base` variable to the first two numbers of the desired IP range. All subnets will use IP CIDR's built on this pattern.

```
vpc_cidr_base = "10.1"
```

### AZ Count

Your VPC can span one or multiple AZ's and you can select the specific AZ's that should be used.

```
aws_azs = "us-west-2a, us-west-2b, us-west-2c, us-west-2d"
az_count = 3
```

### Private Subnet NAT: EC2 Instances vs. NAT Gateways

This module supports either NAT instances or gateways for private subnets in the VPC. This option is selectable by setting one of two variable flags to `1`.

Since Terraform has no concept of conditionals for resources this value is used as a count multiplier to zero out resources associated with the disabled option.

```
# NAT routing via EC2 instances
nat_instance_enabled = 1
nat_gateway_enabled = 0

nat_key_name = "valid_ec2_key_name"
nat_instance_type = "t2.small"
```

```
# NAT routing via NAT gateways
nat_instance_enabled = 0
nat_gateway_enabled = 1
```
