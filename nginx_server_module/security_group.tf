resource "aws_security_group" "nginx-server-sg" {
  name = "${var.srv_name}-sg"
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