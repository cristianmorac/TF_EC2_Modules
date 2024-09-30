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