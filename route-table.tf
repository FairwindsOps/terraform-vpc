#Copyright 2017 Reactive Ops Inc.
#
#Licensed under the Apache License, Version 2.0 (the “License”);
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an “AS IS” BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.


# Routing table for public subnets
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.default.id}"
  tags = "${merge(var.global_tags, map("Name", "public"))}"
}

output "aws_route_table_public_ids" {
  value = ["${aws_route_table.public.id}"]
}

resource "aws_route" "public_internet_gateway" {
  route_table_id = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.default.id}"
}


# Routing table for private subnets
resource "aws_route_table" "private" {
  count = "${((var.multi_az_nat_gateway * var.az_count) + (var.single_nat_gateway * 1))}"
  vpc_id = "${aws_vpc.default.id}"
  tags = "${merge(var.global_tags, map("Name", "private_az${(count.index +1)}"))}"
}

output "aws_route_table_private_ids" {
  value = ["${aws_route_table.private.*.id}"]
}

resource "aws_route" "private_nat_gateway" {
  count = "${((var.multi_az_nat_gateway * var.az_count) + (var.single_nat_gateway * 1))}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
  nat_gateway_id = "${element(aws_nat_gateway.nat_gateway.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  depends_on = ["aws_route_table.private","aws_nat_gateway.nat_gateway"]
}
