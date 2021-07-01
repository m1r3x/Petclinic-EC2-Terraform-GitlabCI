variable "aws_region" {
    default = "us-east-2"
}

variable "ec2_count" {
  default = "1"
}

variable "ami_id" {
    default = "ami-077e31c4939f6a2f3"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "access_key" {
  type = string
  sensitive = true
}

variable "secret_key" {
  type = string
  sensitive = true
}

variable "db_user" {
  default = "demo3_user"
}

variable "db_name" {
  default = "demo3_db"
}

variable "db_password" {
  type = string
  sensitive = true
}