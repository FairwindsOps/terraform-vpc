# nat
resource "aws_security_group" "nat" {
	name = "nat"
	description = "Allow services from the private subnet through NAT"
	vpc_id = "${aws_vpc.default.id}"

	ingress {
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		from_port = 80
		to_port = 80
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		from_port = 123
		to_port = 123
		protocol = "udp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		from_port = 443
		to_port = 443
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		from_port = 4443
		to_port = 4443
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	# git
	ingress {
		from_port = 9418
		to_port = 9418
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	# APNS
	ingress {
		from_port = 5223
		to_port = 5223
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	# APNS
	ingress {
		from_port = 2195
		to_port = 2196
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		cidr_blocks = ["0.0.0.0/0"]
		from_port = -1
		to_port = -1
		protocol = "icmp"
	}

	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	tags {
		Name = "${var.aws_vpc_name}-nat"
	}

}

output "aws_security_group_nat_id" {
  value = "${aws_security_group.nat.id}"
}
