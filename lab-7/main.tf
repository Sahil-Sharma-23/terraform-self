provider "aws" {
  region = "ap-south-1"
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

  tags = {
    Name  = "General-SG"
    Owner = "Sahil Sharma"
  }
}

# ------------------------------------------------
# Display the output named 'my_SG_id'
output "my_SG_id" {
  value = aws_security_group.general.id
}
