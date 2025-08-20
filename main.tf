#### Variables ####
variable "ami_id" {
  description = "ID de la AMI para la instancia EC2"
  default = "ami-00ca32bbc84273381"
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  default = "t2.micro"
}

variable "server_name" {
  description = "Nombre del servidor web"
  default = "web-server"
}

variable "environment" {
  description = "Entorno de la app"
  default = "test"
}

variable "owner" {
  description = "Responsable de la creacion de la infraestructura"
  default = "inoresma@gmail.com"
}

variable "team" {
  description = "A que equipo pertenece"
  default = "DevOps"
}
variable "project" {
  description = "Nombre del proyecto"
  default = "terraform-practice-iac"
}


#### provider ####
provider "aws" { 
    region = "us-east-1"
    } 
#### resource ####
resource "aws_instance" "nginx-server" {
    ami = var.ami_id
    instance_type = var.instance_type

    user_data = <<-EOF
        #!/bin/bash
        sudo yum update -y
        sudo yum install -y nginx
        sudo systemctl start nginx
        sudo systemctl enable nginx
        EOF
    key_name = aws_key_pair.nginx_server_ssh.key_name

    vpc_security_group_ids = [
        aws_security_group.nginx-server-sg.id
        ]
    tags ={
      Name = var.server_name
      Environment = var.environment
      Owner = var.owner
      Team = var.team
      Project = var.project
    }
    }


##### key pair ssh ####
#ssh-keygen -t rsa -b 2048 -f "nginx-server-key"
resource "aws_key_pair" "nginx_server_ssh" {
    key_name = "${var.server_name}-ssh"
    public_key = file("${var.server_name}-key.pub")

    tags ={
      Name = "${var.server_name}-ssh"
      Environment = var.environment
      Owner = var.owner
      Team = var.team
      Project = var.project
    }
}

####### SG ####### 
resource "aws_security_group" "nginx-server-sg" {
  name        = "${var.server_name}-sg"
  description = "Security group allowing SSH and HTTP access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags ={
      Name = "${var.server_name}-sg"
      Environment = var.environment
      Owner = var.owner
      Team = var.team
      Project = var.project
    }
}



#### output ###
output "instance_public_ip" {
    description = "Public IP of the Nginx server"
    value = aws_instance.nginx-server.public_ip
    }

output "instance_public_dns" {
    description = "Public DNS of the Nginx server"
    value = aws_instance.nginx-server.public_dns
    }