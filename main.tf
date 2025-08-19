### provider ###
provider "aws" { 
    region = "us-east-1"
    } 
### resource ###
resource "aws_instance" "nginx-server" {
    ami = "ami-00ca32bbc84273381"
    instance_type = "t2.micro" 
    }