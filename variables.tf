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