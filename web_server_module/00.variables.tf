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