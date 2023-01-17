provider "aws" {}

data "aws_region" "current" {}

output "current_region" {
  value = data.aws_region.current
}

# OUTPUT->
/*
  current_region = {
  "description" = "Asia Pacific (Mumbai)"
  "endpoint" = "ec2.ap-south-1.amazonaws.com"
  "id" = "ap-south-1"
  "name" = "ap-south-1"
}
*/
