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

resource "aws_vpc" "default" {
  cidr_block           = "${var.vpc_cidr_base}.0.0/16"
  instance_tenancy     = var.vpc_instance_tenancy
  enable_dns_support   = var.vpc_enable_dns_support
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  enable_classiclink   = var.vpc_enable_classiclink
  tags = merge(
    var.global_tags,
    {
      "Name" = var.aws_vpc_name
    },
  )
  lifecycle {
    ignore_changes = [tags]
  }
}

output "aws_vpc_id" {
  value = aws_vpc.default.id
}

output "aws_vpc_cidr" {
  value = aws_vpc.default.cidr_block
}

