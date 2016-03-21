resource "aws_eip" "mod_nat" {
    count = "${var.az_count}"
    instance = "${element(aws_instance.nat.*.id, count.index)}"
    vpc = true
}
