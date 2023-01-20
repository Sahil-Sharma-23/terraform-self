/*
Provision Highly available web cluster in any region with Default VPC

CREATE:
  - Security Group for Web Server and ELB.
  - Launch Configuration with auto AMI lookup.
  - Auto Scaling Group using 2 Availability Zones.
  - Classic Load balancer in 2 Availability Zones

### Also updates to Web Server will be via Green/Blue Deployment Stratergy.
*/
provider "aws" {
  region = "ap-south-1"
}

resource "aws_default_vpc" "default" {
  # This is necessary to get VPC IP, since v4.29+
}

data "aws_availability_zones" "working" {
  # Get availability zones.
}

# Provision to dynamically get latest Amazon Linux 2.
data "aws_ami" "latest_amazon_linux" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
}

# Security group
resource "aws_security_group" "general_SG" {
  name        = "General SG"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_default_vpc.default.id

  dynamic "ingress" {
    for_each = ["443", "8080", "80"]
    content {
      description = "TLS from VPC"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name  = "General SG"
    Owner = "Sahil Sharma"
  }
}

# Launch Configuration.
resource "aws_launch_configuration" "web_lc" {
  name            = "Highly-Availabile-WebServer-LC"
  image_id        = data.aws_ami.latest_amazon_linux.id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.general_SG.id]
  user_data       = file("user_data.sh")

  lifecycle {
    create_before_destroy = true
  }
}

# AutoScaling group.
resource "aws_autoscaling_group" "bar" {
  name                      = "ASG-${aws_launch_configuration.web_lc.name}"
  launch_configuration      = aws_launch_configuration.web_lc.name
  max_size                  = 3
  min_size                  = 3
  min_elb_capacity          = 3
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 3
  vpc_zone_identifier       = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]

  dynamic "tag" {
    for_each = {
      "Name" = "WebServer in ASG"
      Owner  = "Sahil Sharma"
      TAGKEY = "TAGVALUE"
    }
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Elastic Load Balancer.
resource "aws_elb" "web_lb" {
  name               = "Highly-Available-WebServer"
  availability_zones = [data.aws_availability_zones.working.names[0], data.aws_availability_zones.working.names[1]]
  security_groups    = [aws_security_group.general_SG.id]
  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = 80
    instance_protocol = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 10
  }
  tags = {
    Name  = "Highly-Available_WebServer-ELB"
    Owner = "Sahil Sharma"
  }
}

resource "aws_default_subnet" "default_az1" {
  availability_zone = data.aws_availability_zones.working.names[0]
}

resource "aws_default_subnet" "default_az2" {
  availability_zone = data.aws_availability_zones.working.names[1]
}

output "web_loadbalancer_url" {
  value = aws_elb.web_lb.dns_name
}
