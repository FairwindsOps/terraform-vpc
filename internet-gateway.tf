resource "aws_internet_gateway" "default" {
	vpc_id = "${aws_vpc.default.id}"
}

output "aws_internet_gateway_id" {
	value = "${aws_internet_gateway.default.id}"
}

