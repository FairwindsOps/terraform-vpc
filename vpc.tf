resource "aws_vpc" "default" {
	cidr_block = "${var.vpc_cidr_base}.0.0/16"
	enable_dns_hostnames = "true"
	tags {
		Name = "${var.aws_vpc_name}"
	}
}

output "aws_vpc_id" {
	value = "${aws_vpc.default.id}"
}

output "aws_vpc_cidr" {
  value = "${aws_vpc.default.cidr_block}"
}