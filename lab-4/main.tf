provider "aws" {
  region = "ap-south-1"
}

resource "aws_default_vpc" "default" {
  # This is to get default VPC ID (required)
}

resource "aws_security_group" "dynamicRG" {
  name        = "Dynamic_resource_group"
  description = "This resource group is created using dynamic group"
  vpc_id      = aws_default_vpc.default.id
  # Actual Ingress block.
  # ingress {
  #   description = "Allow port 10"
  #   from_port   = 10
  #   to_port     = 10
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  # Dynamic ingress
  dynamic "ingress" {
    for_each = ["80", "8080", "90", "9090"]
    content {
      description = "Allow ports: 80, 8080, 90, 9090"
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
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Dynamic SG"
  }

}
