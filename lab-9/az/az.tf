provider "aws" {
  region = "ap-south-1"
}

data "aws_availability_zones" "working_zone" {}

output "availability_zone" {
  value = data.aws_availability_zones.working_zone
}

# OUTPUT->
/*
availability-zone = {
  "all_availability_zones" = tobool(null)
  "exclude_names" = toset(null) $ of string
  "exclude_zone_ids" = toset(null) # of string
  "filter" = toset(null) # of object
  "group_names" = toset([
    "ap-south-1",
  ])
  "id" = "ap-south-1"
  "names" = tolist([
    "ap-south-1a",
    "ap-south-1b",
    "ap-south-1c",
  ])
  "state" = tostring(null)
  "timeouts" = null # object
  "zone_ids" = tolist([
    "aps1-az1",
    "aps1-az3",
    "aps1-az2",
  ])
}
*/
