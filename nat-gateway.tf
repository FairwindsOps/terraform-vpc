resource "aws_nat_gateway" "nat_gateway" {
  count = "${((var.multi_az_nat_gateway * var.az_count) + (var.single_nat_gateway * 1))}"
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
  allocation_id = "${element(aws_eip.mod_nat.*.id, count.index)}"
  depends_on = ["aws_internet_gateway.default","aws_eip.mod_nat","aws_subnet.public"]
}

output "nat_gateway_count" {
  value = "${length(aws_nat_gateway.nat_gateway.*.id)}"
}