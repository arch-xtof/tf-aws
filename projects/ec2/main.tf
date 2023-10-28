resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "SSH, internet and other access"

  dynamic "ingress" {
    for_each = var.ingress_rules_internet

    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.from_port
      protocol    = ingress.value.protocol
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  ingress {
    description = "interal access"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  egress {
    description = "outer internet access"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    owner = "terraform"
  }
}

resource "aws_key_pair" "ec2_key" {
  key_name   = "ec2_key"
  public_key = file(var.public_key_path)
}

resource "aws_instance" "ec2" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.ec2_sg.name]
  key_name        = aws_key_pair.ec2_key.key_name

  user_data = templatefile("${path.module}/templates/user_data.sh", {
    hostname = var.instance_name,
    n        = "${count.index}"
  })

  tags = {
    name  = "${var.instance_name}-${count.index}"
    owner = "terraform"
  }

  count = var.instance_count

  lifecycle {
    ignore_changes = [ami]
  }
}