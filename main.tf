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
}


