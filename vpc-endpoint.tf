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

resource "aws_vpc_endpoint" "s3_endpoint" {
  count        = var.enable_s3_vpc_endpoint ? 1 : 0
  vpc_id       = aws_vpc.default.id
  service_name = "com.amazonaws.${var.aws_region}.s3"
  route_table_ids = concat(
    aws_route_table.private.*.id,
    var.s3_vpc_endpoint_route_table_ids,
  )
  policy = var.s3_vpc_endpoint_policy
}

