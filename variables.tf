variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}

variable "org_name" {}

variable "aws_vpc_name" {
  default = "vpc"
}

variable "aws_azs" {
  description = "comma separated string of availability zones in order of precedence"
  default = "us-east-1a, us-east-1d, us-east-1e, us-east-1c"

}

variable "az_count" {
    description = "number of active availability zones in VPC"
    default = "3"
}

variable "network" {
  default = "10.10"
}

variable "admin_subnet_parent_cidr" {
    description = "parent CIDR for the administrative subnets"
    default = ".0.0/19"
}

variable "admin_subnet_cidrs" {
    description = "CIDRs for the adminsitrative subnets"
    default = {
      zone0 = ".0.0/21"
      zone1 = ".8.0/21"
      zone2 = ".16.0/21"
      zone3 = ".24.0/21"
    }
}

variable "public_subnet_parent_cidr" {
    description = "parent CIDR for the public subnets"
    default = ".32.0/19"
}

variable "public_subnet_cidrs" {
    description = "CIDRs for the public subnets"
    default = {
      zone0 = ".32.0/21"
      zone1 = ".40.0/21"
      zone2 = ".48.0/21"
      zone3 = ".56.0/21"
    }
}

variable "private_prod_subnet_parent_cidr" {
    description = "parent CIDR for the private production subnets"
    default = ".64.0/19"
}

variable "private_prod_subnet_cidrs" {
    description = "CIDRs for the private production subnets"
    default = {
      zone0 = ".64.0/21"
      zone1 = ".72.0/21"
      zone2 = ".80.0/21"
      zone3 = ".88.0/21"
    }
}

variable "private_working_subnet_parent_cidr" {
    description = "parent CIDR for the private working subnets"
    default = ".96.0/19"
}

variable "private_working_subnet_cidrs" {
    description = "CIDRs for the private working subnets"
    default = {
      zone0 = ".96.0/21"
      zone1 = ".104.0/21"
      zone2 = ".112.0/21"
      zone3 = ".120.0/21"
    }
}

variable "aws_ubuntu_ami" {
    default = {
        us-east-1 = "ami-d05e75b8"
        us-west-1 = "ami-736e6536"
        us-west-2 = "ami-37501207"
        ap-northeast-1 = "ami-df4b60de"
        ap-southeast-1 = "ami-2ce7c07e"
        ap-southeast-2 = "ami-1f117325"
        eu-west-1 = "ami-f6b11181"
        sa-east-1 = "ami-71d2676c"
    }
}

variable "aws_nat_ami" {
    default = {
        us-east-1 = "ami-b0210ed8"
        us-west-1 = "ami-1d2b2958"
        us-west-2 = "ami-8b6912bb"
        ap-northeast-1 = "ami-49c29e48"
        ap-southeast-1 = "ami-d482da86"
        ap-southeast-2 = "ami-a164029b"
        eu-west-1 = "ami-5b60b02c"
        sa-east-1 = "ami-8b72db96"
    }
}

variable "nat_instance_enabled" {
    description = "set to 1 to create nat ec2 instances for private subnets"
    default = 0
}

variable "nat_gateway_enabled" {
    description = "set to 1 to create nat gateway instances for private subnets"
    default = 0
}

variable "nat_instance_type" {
    default = "t2.micro"
}

variable "nat_key_name" {
    default = ""
}
