# terraform-vpc

A VPC layout.

* TODO: Add a tertiary AZ. https://github.com/reactiveops/omnia/issues/12
* Based on https://github.com/cloudfoundry-community/terraform-aws-cf-install

# Usage

* Include this in your main.tf:

```
module "vpc" {
  source = "./modules/terraform-aws-vpc-ha"
  network = "${var.network}"
  aws_key_name = "${var.aws_key_name}"
  aws_access_key = "${var.aws_access_key}"
  aws_secret_key = "${var.aws_secret_key}"
  aws_region = "${var.aws_region}"
  aws_primary_az = "${var.aws_primary_az}"
  aws_secondary_az = "${var.aws_secondary_az}"
  org_name = "${var.org_name}"
}
```