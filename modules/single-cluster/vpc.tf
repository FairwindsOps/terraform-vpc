# VPC
resource "aws_vpc" "kube_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.vpc_instance_tenancy
  enable_dns_support   = var.vpc_enable_dns_support
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  tags = merge(
    local.tags,
    {
      "Name" = var.vpc_name
    },
  )

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.kube_vpc.id
  tags = merge(
    local.tags,
    {
      "Name" = var.vpc_name
    },
  )
}

output "aws_vpc_id" {
  value = aws_vpc.kube_vpc.id
}

output "aws_vpc_cidr" {
  value = aws_vpc.kube_vpc.cidr_block
}

# NAT Gateways & EIP
resource "aws_nat_gateway" "nat_gateway" {
  count         = local._count_of_availability_zones
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  allocation_id = element(aws_eip.mod_nat.*.id, count.index)
  tags = merge(
    local.tags,
    {
      "Name" = "Kubernetes NAT Gateway"
    },
  )
  depends_on = [
    aws_internet_gateway.default,
    aws_eip.mod_nat,
    aws_subnet.public,
  ]

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_eip" "mod_nat" {
  count = length(local.avail_zones_list)
  tags = merge(
    local.tags,
    {
      "Name" = "${local.eip_name_prefix}${var.vpc_name}_${local.avail_zones_list[count.index]}"
    },
  )
  vpc = true
}

output "aws_eip_nat_ips" {
  value = [aws_eip.mod_nat.*.public_ip]
}

output "aws_nat_gateway_ids" {
  value = [aws_nat_gateway.nat_gateway.*.id]
}

# Route Tables
## Public
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.kube_vpc.id
  tags = merge(
    local.tags,
    {
      "Name" = "public"
    },
  )
}

output "aws_route_table_public_ids" {
  value = [aws_route_table.public.id]
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id
}

## Private
resource "aws_route_table" "private" {
  count  = local._count_of_availability_zones
  vpc_id = aws_vpc.kube_vpc.id

  tags = merge(
    local.tags,
    {
      "Name" = "private_az${count.index + 1}"
    },
  )
}

output "aws_route_table_private_ids" {
  value = [aws_route_table.private.*.id]
}

resource "aws_route" "private_nat_gateway" {
  count                  = local._count_of_availability_zones
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  nat_gateway_id         = element(aws_nat_gateway.nat_gateway.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  depends_on = [
    aws_route_table.private,
    aws_nat_gateway.nat_gateway,
    aws_vpc.kube_vpc,
  ]
}
