# Routing table for public subnets
resource "aws_route_table" "public" {
	vpc_id = "${aws_vpc.default.id}"

	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_internet_gateway.default.id}"
	}
    tags {
        Name = "public"
    }
}

output "aws_route_table_public_id" {
	value = "${aws_route_table.public.id}"
}

# Routing table for private primary subnets
resource "aws_route_table" "private_primary" {
	vpc_id = "${aws_vpc.default.id}"

	route {
		cidr_block = "0.0.0.0/0"
		instance_id = "${aws_instance.nat-primary.id}"
	}
    tags {
        Name = "private_primary"
    }

}

output "aws_route_table_private_primary_id" {
	value = "${aws_route_table.private_primary.id}"
}

# Routing table for private secondary subnets
resource "aws_route_table" "private_secondary" {
	vpc_id = "${aws_vpc.default.id}"

	route {
		cidr_block = "0.0.0.0/0"
		instance_id = "${aws_instance.nat-secondary.id}"
	}
    tags {
        Name = "private_secondary"
    }
}

output "aws_route_table_private_secondary_id" {
	value = "${aws_route_table.private_secondary.id}"
}
