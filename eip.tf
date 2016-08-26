resource "aws_eip" "mod_nat" {
  count = "${var.az_count}"
  vpc = true
}
