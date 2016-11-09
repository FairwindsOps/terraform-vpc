resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
  tags = "${merge(var.global_tags, map("Name", "${var.aws_vpc_name}"))}"
}
