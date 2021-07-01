resource "aws_instance" "app" {
    ami           = var.ami_id
    instance_type = var.instance_type
    subnet_id     = module.vpc.subnet_public_id
    key_name = "demo3-m.m"
    
    vpc_security_group_ids = [ aws_security_group.app-sg.id ]
    associate_public_ip_address = true

    tags = {
        Name = "app"
    }

    depends_on = [ module.vpc.vpc_id, module.vpc.igw_id, aws_db_instance.database]

    user_data = <<EOF
#!/bin/sh

export MYSQL_USER=${var.db_user} 
export MYSQL_PASS=${var.db_password}
export MYSQL_URL="jdbc:mysql://${aws_db_instance.database.address}:3306/${var.db_name}"

amazon-linux-extras install java-openjdk11 -y

aws configure set aws_access_key_id ${var.access_key}
aws configure set aws_secret_access_key ${var.secret_key}
aws configure set default.region us-east-2

aws s3api get-object --bucket demo3-mahammadjan --key petclinic.jar petclinic.jar

java -Dspring.profiles.active=mysql -jar petclinic.jar 

EOF
}

resource "aws_security_group" "app-sg" {
  name        = "app-security-group"
  description = "app-security-group"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "SSH"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    description = "PetclinicWeb"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}