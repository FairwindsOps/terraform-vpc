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

# Routing table for private subnets
resource "aws_route_table" "private" {
  count = "${var.az_count}"
  vpc_id = "${aws_vpc.default.id}"
  tags {
      Name = "private_az${(count.index +1)}"
  }
}

resource "aws_route" "private_nat_instance" {
  count = "${var.az_count * var.nat_instance_enabled}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
  instance_id = "${element(aws_instance.nat.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  depends_on = ["aws_route_table.private","aws_instance.nat"]
}

resource "aws_route" "private_nat_gateway" {
  count = "${var.az_count * var.nat_gateway_enabled}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
  nat_gateway_id = "${element(aws_nat_gateway.nat_gateway.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  depends_on = ["aws_route_table.private","aws_nat_gateway.nat_gateway"]
}
