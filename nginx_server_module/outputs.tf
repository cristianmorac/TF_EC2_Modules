output "server_public_ip" {
	description = "IP pública instancia EC2"
	value = aws_instance.nginx-server.public_ip
}

output "server_public_dns" {
	description = "DNS público instancia EC2"
	value = aws_instance.nginx-server.public_dns
}