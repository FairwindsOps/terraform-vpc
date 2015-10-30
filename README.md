# terraform-vpc

A VPC layout.

* TODO: Add a tertiary AZ. https://github.com/reactiveops/omnia/issues/12
* Based on https://github.com/cloudfoundry-community/terraform-aws-cf-install

# Usage

* Required variables:

```
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_key_name" {}
variable "aws_region" {}

variable "aws_azs" {}
variable "az_count" {}

variable "network" {}
variable "org_name" {}
```

* Example variables:

```
aws_key_name = "nat"
aws_azs = "us-west-2a, us-west-2b, us-west-2c, us-west-2d"
az_count = 3
network = "10.0"
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

  network = "${var.network}"
  nat_key_name = "${var.aws_key_name}"
}
```