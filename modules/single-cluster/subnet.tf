# Subnet creation
## Admin
resource "aws_subnet" "admin" {
  count             = var.enable_admin_subnet == false ? 0 : local._count_of_availability_zones
  vpc_id            = aws_vpc.kube_vpc.id
  cidr_block        = local.admin_cidr_subnets[count.index]
  availability_zone = local.avail_zones_list[count.index]
  tags = merge(
    local.admin_subnet_tags,
    {
      "Name" = "Admin Subnet"
    }
  )
}

resource "aws_route_table_association" "admin" {
  count          = var.enable_admin_subnet == false ? 0 : local._count_of_availability_zones
  subnet_id      = element(aws_subnet.admin.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

## Public
resource "aws_subnet" "public" {
  count             = local._count_of_availability_zones
  vpc_id            = aws_vpc.kube_vpc.id
  cidr_block        = local.public_cidr_subnets[count.index]
  availability_zone = local.avail_zones_list[count.index]
  tags = merge(
    local.public_subnet_tags,
    {
      "Name" = "Public Subnet"
    }
  )
}

resource "aws_route_table_association" "public" {
  count          = local._count_of_availability_zones
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

## Private
resource "aws_subnet" "private" {
  count             = local._count_of_availability_zones
  vpc_id            = aws_vpc.kube_vpc.id
  cidr_block        = local.private_cidr_subnets[count.index]
  availability_zone = local.avail_zones_list[count.index]
  tags = merge(
    local.private_subnet_tags,
    {
      "Name" = "Private Subnet"
    }
  )
}

resource "aws_route_table_association" "private" {
  count          = local._count_of_availability_zones
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}
