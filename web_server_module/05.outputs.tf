#### output ###
output "server_public_ip" {
    description = "Public IP of the Nginx server"
    value = aws_instance.web-server.public_ip
    }

output "server_public_dns" {
    description = "Public DNS of the Nginx server"
    value = aws_instance.web-server.public_dns
    }