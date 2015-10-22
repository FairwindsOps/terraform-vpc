resource "aws_eip" "nat_primary" {
	instance = "${aws_instance.nat-primary.id}"
	vpc = true
}

resource "aws_eip" "nat_secondary" {
	instance = "${aws_instance.nat-secondary.id}"
	vpc = true
}
