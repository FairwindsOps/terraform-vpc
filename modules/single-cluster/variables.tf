# Required Variables

variable "vpc_cidr" {
  description = "The base CIDR that all subnets and vpcs will be created from. (Format 1.2.3.4/6)"
}

variable "vpc_name" {
  description = "The name tag of the VPC you are creating."
}

variable "availability_zones" {
  description = "The available zones, that matches the terraform provider you are using, for the VPC subnets and Nat Gateways. Format (us-west-2a,us-west-2b)"
}

# Optional Variables
## Exposed VPC Settings
variable "vpc_instance_tenancy" {
  default = "default"
}

variable "vpc_enable_dns_support" {
  default = "true"
}

variable "vpc_enable_dns_hostnames" {
  default = "true"
}

variable "vpc_enable_classiclink" {
  default = "false"
}

## Tagging Settings
variable "extra_tags" {
  type        = "map"
  description = "Map of tags to apply in addition to already predefined tags of the module."
  default     = {}
}

# Local Vars
locals {
  default_tags = {
    "ManagedVia" = "Terraform"
    "Author"     = "ReactiveOps"
  }

  tags             = "${merge(local.default_tags, var.extra_tags)}"
  avail_zones_list = "${split(",", var.availability_zones)}"
}
