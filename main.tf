### provider ###
provider "aws" { 
    region = "us-east-1"
    } 
### resource ###
resource "aws_instance" "nginx-server" {
    ami = "ami-00ca32bbc84273381"
    instance_type = "t2.micro" 

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
    }


##### key pair ssh ####
#ssh-keygen -t rsa -b 2048 -f "nginx-server-key"
resource "aws_key_pair" "nginx_server_ssh" {
    key_name = "nginx-server-ssh"
    public_key = file("nginx-server-key.pub")
}

####### SG ####### 
resource "aws_security_group" "nginx-server-sg" {
  name        = "nginx-server-sg"
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
}