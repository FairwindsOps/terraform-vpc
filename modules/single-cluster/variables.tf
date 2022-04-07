# Required Variables
variable "vpc_cidr" {
  description = "The base CIDR that all subnets and vpcs will be created from. (Format 1.2.3.4/6)"
}

variable "public_subnets_list" {
  type        = list(string)
  description = "A list of the subnets to create for public subnets"
}

variable "private_subnets_list" {
  type        = list(string)
  description = "A list of the subnets to create for private subnets"
}

variable "admin_subnets_list" {
  type        = list(string)
  description = "A list of the subnets to create for admin subnets"
  default     = null
}

variable "enable_admin_subnet" {
  type        = bool
  description = "A true/false value to enable the admin subnets"
  default     = true
}

variable "vpc_name" {
  description = "The name tag of the VPC you are creating."
}

variable "availability_zones" {
  description = "The available zones for the VPC subnets and NAT Gateways. Format (us-west-2a,us-west-2b). NOTE the counts for each subnet group and AZs listed MUST MATCH."
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
variable "extra_tags_global" {
  type        = map(string)
  description = "Map of tags to apply in addition to already predefined tags of the module."
  default     = {}
}

## Tagging Settings
variable "extra_tags_admin_subnet" {
  type        = map(string)
  description = "Map of tags to apply in addition to already predefined tags of the module."
  default     = {}
}

## Tagging Settings
variable "extra_tags_public_subnet" {
  type        = map(string)
  description = "Map of tags to apply in addition to already predefined tags of the module."
  default     = {}
}

## Tagging Settings
variable "extra_tags_private_subnet" {
  type        = map(string)
  description = "Map of tags to apply in addition to already predefined tags of the module."
  default     = {}
}

## Tagging Settings
variable "elastic_ip_name_prefix" {
  type        = string
  description = "The name prefix for each eip."
  default     = ""
}

# Local Vars
locals {
  eip_name_prefix = length(var.elastic_ip_name_prefix) > 0 ? "${var.elastic_ip_name_prefix}-" : ""
  default_tags = {
    "ManagedVia" = "Terraform"
    "Author"     = "Fairwinds"
  }

  tags                = merge(local.default_tags, var.extra_tags_global)
  admin_subnet_tags   = merge(local.tags, var.extra_tags_admin_subnet)
  private_subnet_tags = merge(local.tags, var.extra_tags_private_subnet)
  public_subnet_tags  = merge(local.tags, var.extra_tags_public_subnet)
  avail_zones_list    = split(",", var.availability_zones)
}

# Usage validation
## NOTE: This is a hack for terraform to validate inputs to the module.
##       The idea here is that you should always pass the same number of AZs
##       into the module as the count of subnets. Otherwise you are using the
##       module incorrectly. If you want three AZs, then you must pass in 3
##       subnets for public, private and admin subnet areas.
## The error for invalid usage is "Count is less than zero: -1"
locals {
  _count_of_availability_zones          = length(local.avail_zones_list)
  _public_subnets_count_minus_az_count  = length(var.public_subnets_list) - local._count_of_availability_zones
  _private_subnets_count_minus_az_count = length(var.private_subnets_list) - local._count_of_availability_zones
  _admin_subnets_count_minus_az_count   = var.enable_admin_subnet == false ? 0 : length(var.admin_subnets_list) - local._count_of_availability_zones
}

resource "null_resource" "validate_public_subnet_count_matches_availability_zone_count" {
  count = local._public_subnets_count_minus_az_count == 0 ? 0 : -1
}

resource "null_resource" "validate_private_subnet_count_matches_availability_zone_count" {
  count = local._private_subnets_count_minus_az_count == 0 ? 0 : -1
}

resource "null_resource" "validate_admin_subnet_count_matches_availability_zone_count" {
  count = local._admin_subnets_count_minus_az_count == 0 ? 0 : -1
}
