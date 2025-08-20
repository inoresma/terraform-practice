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
    tags ={
      Name = "nginx-server"
      Environment = "test"
      Owner = "inoresma@gmail.com"
      Team = "DevOps"
      Project = "terraform-practice-iac"
    }
    }


##### key pair ssh ####
#ssh-keygen -t rsa -b 2048 -f "nginx-server-key"
resource "aws_key_pair" "nginx_server_ssh" {
    key_name = "nginx-server-ssh"
    public_key = file("nginx-server.key.pub")

    tags ={
      Name = "nginx-server-ssh"
      Environment = "test"
      Owner = "inoresma@gmail.com"
      Team = "DevOps"
      Project = "terraform-practice-iac"
    }
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

  tags ={
      Name = "nginx-server-sg"
      Environment = "test"
      Owner = "inoresma@gmail.com"
      Team = "DevOps"
      Project = "terraform-practice-iac"
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