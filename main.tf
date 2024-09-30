provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "nginx-server" {
  ami = "ami-0e86e20dae9224db8"
  instance_type = "t3.micro"
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
}

resource "aws_key_pair" "nginx-server-ssh" {
  # archivo que va a tener en la instancia
  key_name = "nginx-server-ssh"
  # ubucación de la llave
  public_key = file("nginx-server.key.pub")
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
}



