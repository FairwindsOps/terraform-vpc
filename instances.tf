resource "aws_instance" "nat-primary" {
	ami = "${lookup(var.aws_nat_ami, var.aws_region)}"
	instance_type = "t2.micro"
	key_name = "${var.aws_key_name}"
	security_groups = ["${aws_security_group.nat.id}"]
	subnet_id = "${aws_subnet.public_primary.id}"
	associate_public_ip_address = true
	source_dest_check = false
	tags {
		Name = "${var.org_name}-nat-primary"
	}
}

resource "aws_instance" "nat-secondary" {
	ami = "${lookup(var.aws_nat_ami, var.aws_region)}"
	instance_type = "t2.micro"
	key_name = "${var.aws_key_name}"
	security_groups = ["${aws_security_group.nat.id}"]
	subnet_id = "${aws_subnet.public_secondary.id}"
	associate_public_ip_address = true
	source_dest_check = false
	tags {
		Name = "${var.org_name}-nat-secondary"
	}
}
