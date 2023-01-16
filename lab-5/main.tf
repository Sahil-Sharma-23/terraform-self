# Achieve zero downtime with EIP and LifeCycle.

provider "aws" {
  region = "ap-south-1"
}

resource "aws_default_vpc" "default" {
  # This is to get VPC ID (required).
}

resource "aws_eip" "web_server" {
  instance = aws_instance.web_server.id
  vpc      = true # Default value.
  tags = {
    Name  = "EIP for zero-donwtime web-server"
    Owner = "Sahil Sharma"
  }
}

resource "aws_instance" "web_server" {
  ami                    = "ami-0cca134ec43cf708f" # Amazon Linux 2
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.new_security_group.id]

  user_data = file("user_data.sh")

  tags = {
    Name  = "Zero-downtime Web Server"
    Owner = "Sahil Sharma"
  }

  # By default when changing, Terraform first destroys the instance
  # and then creates a new instance.
  lifecycle {
    create_before_destroy = true
    # Enabling the above will change the behaviour of the Instance,
    # first new instance will be provisioned and then older will be terminated.
  }
}

resource "aws_security_group" "new_security_group" {
  name        = "WebServer_new"
  description = "Security group for my WebServer"
  vpc_id      = aws_default_vpc.default.id

  dynamic "ingress" {
    for_each = ["80", "8080", "90", "9090", "443"]
    content {
      description = "Allow port HTTP"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    description = "Allow all ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Zero-downtime WebServer SG"
    Owner = "Sahil Sharma"
  }
}

