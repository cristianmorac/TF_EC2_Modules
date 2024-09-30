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
}

resource "aws_key_pair" "nginx-server-ssh" {
  # archivo que va a tener en la instancia
  key_name = "nginx-server-ssh"
  # ubucación de la llave
  public_key = file("nginx-server.key.pub")
}



