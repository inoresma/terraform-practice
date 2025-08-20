#### resource ####
resource "aws_instance" "web-server" {
    ami = var.ami_id
    instance_type = var.instance_type

    associate_public_ip_address = true
    user_data = <<-EOF
        #!/bin/bash
        sudo yum update -y
        sudo yum install -y nginx
        sudo systemctl start nginx
        sudo systemctl enable nginx
        EOF
    key_name = aws_key_pair.web-server_ssh.key_name

    vpc_security_group_ids = [
        aws_security_group.web-server-sg.id
        ]
    tags ={
      Name = var.server_name
      Environment = var.environment
      Owner = var.owner
      Team = var.team
      Project = var.project
    }
    subnet_id = "subnet-0a4bd2a7a44c202bc"
    }