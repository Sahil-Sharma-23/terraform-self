provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "my_own_server" {
  ami           = "ami-0cca134ec43cf708f"
  instance_type = "t2.micro"
  user_data     = file("user_data.sh")
  tags = {
    Name  = "My Own Server"
    Owner = "Sahil Sharma"
  }
}

