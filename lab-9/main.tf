provider "aws" {}

data "aws_region" "current" {} # OUTPUT->


data "aws_caller_identity" "current" {} # OUTPUT->


data "aws_availability_zones" "working" {} # OUTPUT->

# Get all vpcs
data "aws_vpcs" "vpcs" {} # OUTPUT->
# vpcs = {
#   "filter" = toset(null) /* of object */
#   "id" = "ap-south-1"
#   "ids" = tolist([
#     "vpc-0f0b31a23065b9073",
#   ])
#   "tags" = tomap(null) /* of string */
#   "timeouts" = null /* object */
# }

data "aws_vpc" "vpc" {} # OUTPUT->
# vpc = {
#   "arn" = "arn:aws:ec2:ap-south-1:398301125541:vpc/vpc-0f0b31a23065b9073"
#   "cidr_block" = "172.31.0.0/16"
#   "cidr_block_associations" = tolist([
#     {
#       "association_id" = "vpc-cidr-assoc-0422c182d5e059f0c"
#       "cidr_block" = "172.31.0.0/16"
#       "state" = "associated"
#     },
#   ])
#   "default" = true
#   "dhcp_options_id" = "dopt-07261c4b373f72ac2"
#   "enable_dns_hostnames" = true
#   "enable_dns_support" = true
#   "enable_network_address_usage_metrics" = true
#   "filter" = toset(null) /* of object */
#   "id" = "vpc-0f0b31a23065b9073"
#   "instance_tenancy" = "default"
#   "ipv6_association_id" = ""
#   "ipv6_cidr_block" = ""
#   "main_route_table_id" = "rtb-0b892d263e42f3488"
#   "owner_id" = "398301125541"
#   "state" = tostring(null)
#   "tags" = tomap({
#     "Name" = "PROD"
#   })
#   "timeouts" = null /* object */
# }



# output "vpc" {
#   value = data.aws_vpc.vpc.id
# }

# output "vpcs" {
#   value = data.aws_vpcs.vpcs
# }

# output "availability-zone" {
#   value = data.aws_availability_zones.working
# }

# output "current_region" {
#   value = data.aws_region.current
# }

# output "caller_identity" {
#   value = data.aws_caller_identity.current
# }
