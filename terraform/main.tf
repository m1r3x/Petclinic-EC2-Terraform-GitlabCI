terraform {
  required_providers {
    aws = {
      version = "3.40.0"
      source = "hashicorp/aws"
    }
  }
}


provider "aws" {
    access_key = var.access_key
    secret_key = var.secret_key
    region = var.aws_region
}

module "vpc" {
    source = "./modules"
    vpc_name = "demo3-vpc"
    vpc_cidr = "192.168.0.0/16"
    public_cidr = "192.168.1.0/24"
    private1_cidr = "192.168.2.0/24"
    private2_cidr = "192.168.3.0/24"
    private1_az = data.aws_availability_zones.available.names[0]
    private2_az = data.aws_availability_zones.available.names[1]
    public_az = data.aws_availability_zones.available.names[0]
}

data "aws_availability_zones" "available" {
  state = "available"
}
