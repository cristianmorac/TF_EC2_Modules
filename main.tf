provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "nginx-server" {
  ami = var.ami_id
  instance_type = var.instance_type
  # ejecutar script en instancia
  user_data = <<-EOF
              #!/bin/bash
              sudo apt install -y nginx
              sudo systemctl enable nginx
              sudo systemctl start nginx
              EOF
  # agregar llave pública
  key_name = aws_key_pair.nginx-server-ssh.key_name
  # security group
  vpc_security_group_ids = [aws_security_group.nginx-server-sg.id]

  tags = {
		Name = var.srv_name # nombre de la instancia
		Environment = var.environment # ambiente
		Owner = "owner@correo.com" # Dueño
		Team = "DevOps" # Equipo
		Project = "Webinar"		
	}
}

resource "aws_key_pair" "nginx-server-ssh" {
  # archivo que va a tener en la instancia
  key_name = "nginx-server-ssh"
  # ubucación de la llave
  public_key = file("nginx-server.key.pub")

  tags = {
		Name = "${var.srv_name}-sh" # nombre de la instancia
		Environment = var.environment # ambiente
		Owner = "owner@correo.com" # Dueño
		Team = "DevOps" # Equipo
		Project = "Webinar"		
	}
}

resource "aws_security_group" "nginx-server-sg" {
  name = "nginx-server-sg"
  description = "Security group allowing ssh y HTTP acces"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # accceder desde cualquier IP
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # accceder desde cualquier IP
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1" # aceptar cualquier protocolo
    cidr_blocks = ["0.0.0.0/0"] # accceder desde cualquier IP
  }

  tags = {
		Name = "${var.srv_name}-output" # nombre de la instancia
		Environment = var.environment # ambiente
		Owner = "owner@correo.com" # Dueño
		Team = "DevOps" # Equipo
		Project = "Webinar"		
	}
}

output "server_public_ip" {
	description = "IP pública instancia EC2"
	value = aws_instance.nginx-server.public_ip
}

output "server_public_dns" {
	description = "DNS público instancia EC2"
	value = aws_instance.nginx-server.public_dns
}

variable "ami_id" {
  type        = string
  description = "Sistema operativo"
  default = "ami-0e86e20dae9224db8"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "tipo de instancia EC2"
}

variable "srv_name" {
  type        = string
  default     = "webserver"
  description = "nombre del servidor"
}

variable "environment" {
  type        = string
  default     = "test"
  description = "Ambiente de la app"
}





