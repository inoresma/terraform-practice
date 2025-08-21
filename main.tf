#### Guardar tfstate ####
terraform {
    backend "s3" {
        bucket = "s3-terraform-practice-inoresma"
        key = "terraform-tfstate/terraform.tfstate"
        region = "us-east-1"
    }
}

#### Modulos ####

module "web_server_dev" {
    source = "./web_server_module"
    
    ami_id = "ami-00ca32bbc84273381"
    instance_type = "t2.micro"
    server_name = "web-server-dev"
    environment = "dev"
}

module "web_server_qa" {
    source = "./web_server_module"
    
    ami_id = "ami-0a232144cf20a27a5"
    instance_type = "t2.micro"
    server_name = "web-server-qa"
    environment = "qa"
}


#### outputs ###
output "server_dev_ip" {
    description = "Public IP of the Nginx server"
    value = module.web_server_dev.server_public_ip
    }
    
output "server_dev_dns" {
    description = "Public DNS of the Nginx server"  
    value = module.web_server_dev.server_public_dns
    }

## QA outputs ##
output "server_qa_ip" {
    description = "Public IP of the Nginx server"
    value = module.web_server_qa.server_public_ip
    }
    
output "server_qa_dns" {
    description = "Public DNS of the Nginx server"  
    value = module.web_server_qa.server_public_dns
    }


# aws_instance.web-server:
#terraform import aws_instance.web-server id_de_la_instancia
#terraform state show aws_instance_web-server
resource "aws_instance" "web-server" {
    ami = "ami-00ca32bbc84273381"
    instance_type = "t2.micro"
    
    tags ={
      Name = "server-web"
      Environment = "test"
      Owner = "inoresma@gmail.com"
      Team = "DevOps"
      Project = "practice"
    }
    
}