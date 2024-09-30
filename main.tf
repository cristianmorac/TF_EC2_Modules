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

