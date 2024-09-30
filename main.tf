module "nginx_server_dev" {
  source = "./nginx_server_module"
  ami_id = "ami-0e86e20dae9224db8"
  instance_type = "t3.micro"
  srv_name = "webserve"
  environment = "dev"
}

module "nginx_server_qa" {
  source = "./nginx_server_module"
  ami_id = "ami-0e86e20dae9224db8"
  instance_type = "t3.micro"
  srv_name = "webserve"
  environment = "qa"
}

output "nginx_dev_public_ip" {
	description = "IP pública instancia EC2"
	value = module.nginx_server_dev.server_public_ip
}

output "nginx_dev_public_dns" {
	description = "DNS público instancia EC2"
	value = module.nginx_server_dev.server_public_dns
}

output "nginx_qa_public_ip" {
	description = "IP pública instancia EC2"
	value = module.nginx_server_qa.server_public_ip
}

output "nginx_qa_public_dns" {
	description = "DNS público instancia EC2"
	value = module.nginx_server_qa.server_public_ip
}

