# Build WebServer during Bootstrap with External template file File

provider "aws" {
  region = "ap-south-1"
}

resource "aws_default_vpc" "default" {} # This is to get VPC ID.

resource "aws_instance" "web_server" {
  ami                    = "ami-0cca134ec43cf708f" # Amazon Linux 2
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.new_security_group.id]

  user_data = templatefile("user_data.sh.tpl", {
    first_name  = "Sahil"
    last_name   = "Sharma"
    other_names = ["Sanjashree", "Vishal", "Monu", "Sweta", "Sarang", "Gaurav"]
  })

  tags = {
    Name  = "Web Server"
    Owner = "Sahil Sharma"
  }
}

resource "aws_security_group" "new_security_group" {
  name        = "WebServer_new"
  description = "Security group for my WebServer"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    description = "Allow port HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow port HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "WebServer by TerraForm"
    Owner = "Sahil Sharma"
  }
}

