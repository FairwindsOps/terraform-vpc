variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "aws_key_name" {}
variable "aws_region" {
  default = "us-east-1"
}

variable "org_name" {}

variable "aws_primary_az" {
  default = "us-east-1a"
}

variable "aws_secondary_az" {
  default = "us-east-1c"
}

variable "env_count" {
  default = 1
}

variable "network" {
  default = "10.10"
}

variable "aws_vpc_name" {
  default = "vpc"
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
