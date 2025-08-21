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