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

resource "aws_nat_gateway" "nat_gateway" {
  count = "${((var.multi_az_nat_gateway * var.az_count) + (var.single_nat_gateway * 1))}"
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
  allocation_id = "${element(aws_eip.mod_nat.*.id, count.index)}"
  depends_on = ["aws_internet_gateway.default","aws_eip.mod_nat","aws_subnet.public"]
}

output "aws_nat_gateway_count" {
  value = "${length(aws_nat_gateway.nat_gateway.*.id)}"
}

output "aws_nat_gateway_ids" {
  value = ["${aws_nat_gateway.nat_gateway.*.id}"]
}
