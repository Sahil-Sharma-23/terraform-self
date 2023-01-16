provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "my_server_1" {
  ami                    = "ami-0cca134ec43cf708f"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.general.id]
  tags = {
    Name  = "My Server 1"
    Owner = "Sahil Sharma"
  }

  depends_on = [aws_security_group.general]
}

resource "aws_instance" "my_server_2" {
  ami                    = "ami-0cca134ec43cf708f"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.general.id]
  tags = {
    Name  = "My Server 2"
    Owner = "Sahil Sharma"
  }

  depends_on = [aws_security_group.general]
}

resource "aws_instance" "my_server_3" {
  ami                    = "ami-0cca134ec43cf708f"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.general.id]
  tags = {
    Name  = "My Server 3"
    Owner = "Sahil Sharma"
  }

  depends_on = [aws_security_group.general]
}

resource "aws_security_group" "general" {
  name = "My general security group"

  dynamic "ingress" {
    for_each = ["80", "8080", "443"]
    content {
      description = "Allow HTTPS ports"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    description = "Allow all other ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "General-SG"
    Owner = "Sahil Sharma"
  }
}
