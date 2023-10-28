variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "ingress_rules_internet" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
  }))

  default = [{ from_port = 22, to_port = 22, protocol = "tcp", description = "allow ssh from internet" }]
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "instance_name" {
  type    = string
  default = "vm"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "public_key_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}
