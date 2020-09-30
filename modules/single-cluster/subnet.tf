# Subnet creation
## Admin
resource "aws_subnet" "admin" {
  count             = var.enable_admin_subnet == false ? 0 : local._count_of_availability_zones
  vpc_id            = aws_vpc.kube_vpc.id
  cidr_block        = local.admin_cidr_subnets[count.index]
  availability_zone = local.avail_zones_list[count.index]
  tags = merge(
    local.tags,
    {
      "Name" = "Admin Subnet"
    },
  )
}

output "aws_subnet_admin_ids" {
  value = [aws_subnet.admin.*.id]
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
    local.tags,
    {
      "Name" = "Public Subnet"
    },
  )
}

output "aws_subnet_public_ids" {
  value = [aws_subnet.public.*.id]
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
    local.tags,
    {
      "Name" = "Private Subnet"
    },
  )
}

output "aws_subnet_private_ids" {
  value = [aws_subnet.private.*.id]
}

resource "aws_route_table_association" "private" {
  count          = local._count_of_availability_zones
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}
