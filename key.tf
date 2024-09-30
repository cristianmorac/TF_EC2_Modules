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