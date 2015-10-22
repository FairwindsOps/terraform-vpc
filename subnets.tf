#
# Subnets are a subnet in an AZ, a route table asscoiation, and an output for the subnet id.
#

# public_primary
resource "aws_subnet" "public_primary" {
	vpc_id = "${aws_vpc.default.id}"
	cidr_block = "${var.network}.0.0/24"
	availability_zone = "${var.aws_primary_az}"
	tags {
		Name = "public_primary"
	}
}

resource "aws_route_table_association" "public_public_primary" {
	subnet_id = "${aws_subnet.public_primary.id}"
	route_table_id = "${aws_route_table.public.id}"
}

output "aws_subnet_public_primary_id" {
	value = "${aws_subnet.public_primary.id}"
}


# private_prod_primary
resource "aws_subnet" "private_prod_primary" {
	vpc_id = "${aws_vpc.default.id}"
	cidr_block = "${var.network}.1.0/24"
	availability_zone = "${var.aws_primary_az}"
	tags {
		Name = "private_prod_primary"
	}
}

resource "aws_route_table_association" "private_private_prod_primary" {
	subnet_id = "${aws_subnet.private_prod_primary.id}"
	route_table_id = "${aws_route_table.private_primary.id}"
}

output "aws_subnet_private_prod_primary_id" {
  value = "${aws_subnet.private_prod_primary.id}"
}


# private-working-primary
resource "aws_subnet" "private_working_primary" {
	vpc_id = "${aws_vpc.default.id}"
	cidr_block = "${var.network}.3.0/24"
	availability_zone = "${var.aws_primary_az}"
	tags {
		Name = "private_working_primary"
	}
}

resource "aws_route_table_association" "private_private_working_primary" {
	subnet_id = "${aws_subnet.private_working_primary.id}"
	route_table_id = "${aws_route_table.private_primary.id}"
}

output "aws_subnet_private_working_primary_id" {
  value = "${aws_subnet.private_working_primary.id}"
}


# administration
resource "aws_subnet" "administration_primary" {
	vpc_id = "${aws_vpc.default.id}"
	cidr_block = "${var.network}.4.0/24"
	availability_zone = "${var.aws_primary_az}"
	tags {
		Name = "administration_primary"
	}
}

resource "aws_route_table_association" "private_administration_primary" {
	subnet_id = "${aws_subnet.administration_primary.id}"
	route_table_id = "${aws_route_table.private_primary.id}"
}

output "aws_subnet_administration_primary_id" {
  value = "${aws_subnet.administration_primary.id}"
}

###
# Secondary AZ's subnets
###

# public_secondary
resource "aws_subnet" "public_secondary" {
	vpc_id = "${aws_vpc.default.id}"
	cidr_block = "${var.network}.5.0/24"
	availability_zone = "${var.aws_secondary_az}"
	tags {
		Name = "public_secondary"
	}
}

resource "aws_route_table_association" "public_public_secondary" {
	subnet_id = "${aws_subnet.public_secondary.id}"
	route_table_id = "${aws_route_table.public.id}"
}

output "aws_subnet_public_secondary_id" {
  value = "${aws_subnet.public_secondary.id}"
}


# private_prod_secondary
resource "aws_subnet" "private_prod_secondary" {
	vpc_id = "${aws_vpc.default.id}"
	cidr_block = "${var.network}.6.0/24"
	availability_zone = "${var.aws_secondary_az}"
	tags {
		Name = "private_prod_secondary"
	}
}

resource "aws_route_table_association" "private_private_prod_secondary" {
	subnet_id = "${aws_subnet.private_prod_secondary.id}"
	route_table_id = "${aws_route_table.private_secondary.id}"
}

output "aws_subnet_private_prod_secondary_id" {
  value = "${aws_subnet.private_prod_secondary.id}"
}

# private_working_secondary
resource "aws_subnet" "private_working_secondary" {
	vpc_id = "${aws_vpc.default.id}"
	cidr_block = "${var.network}.7.0/24"
	availability_zone = "${var.aws_secondary_az}"
	tags {
		Name = "private_working_secondary"
	}
}

resource "aws_route_table_association" "private_private_working_secondary" {
	subnet_id = "${aws_subnet.private_working_secondary.id}"
	route_table_id = "${aws_route_table.private_secondary.id}"
}

output "aws_subnet_private_working_secondary_id" {
  value = "${aws_subnet.private_working_secondary.id}"
}

