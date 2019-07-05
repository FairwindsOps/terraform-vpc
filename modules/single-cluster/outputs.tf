output "provisioned_cidrs" {
  value = {
    public_cidr_subnets  = "${local.public_cidr_subnets}"
    private_cidr_subnets = "${local.private_cidr_subnets}"
    admin_cidr_subnets   = "${local.admin_cidr_subnets}"
  }
}
