#Copyright 2019 Fairwinds Inc.
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

resource "aws_eip" "mod_nat" {
  count = var.multi_az_nat_gateway * var.az_count + var.single_nat_gateway * 1
  tags  = var.global_tags
  vpc   = true
}

output "aws_eip_nat_ips" {
  value = aws_eip.mod_nat.*.public_ip
}

