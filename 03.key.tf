##### key pair ssh ####
#ssh-keygen -t rsa -b 2048 -f "nginx-server-key"
resource "aws_key_pair" "web-server_ssh" {
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