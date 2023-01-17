provider "aws" {
  region = "ap-south-1"
}

# Get all VPC's
data "aws_vpcs" "vpcs" {}

output "vpcs" {
  value = data.aws_vpcs.vpcs
}

# OUTPUT->
/*
vpcs = {
  "filter" = toset(null) # of object
  "id" = "ap-south-1"
  "ids" = tolist([
    "vpc-0f0b31a23065b9073",
  ])
  "tags" = tomap(null) # of string
  "timeouts" = null # object
}
*/

# Get single VPC
data "aws_vpc" "vpc" {}

output "vpc" {
  value = data.aws_vpc.vpc.id
}
