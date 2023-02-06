provider "aws" {
  region = "ap-south-1"
}

variable "private_subnets_cidr_blocks" {
  
}
variable "public_subnets_cidr_blocks" {
  
}
variable "vpc_cidr_block" {
  
}

data "aws_availability_zones" "azs" {
  
}
module "our-app-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"


  name = "our-app-vpc"
  cidr = var.vpc_cidr_block
  private_subnets = var.private_subnets_cidr_blocks
  public_subnets = var.public_subnets_cidr_blocks
  azs = data.aws_availability_zones.azs.names


}