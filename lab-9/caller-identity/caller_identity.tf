provider "aws" {
  region = "ap-south-1"
}

data "aws_caller_identity" "current" {}

output "caller_identity" {
  value = data.aws_caller_identity.current
}

# OUTPUT->
/*
caller_identity = {
  "account_id" = "398301125541"
  "arn" = "arn:aws:iam::398301125541:user/terraform"
  "id" = "398301125541"
  "user_id" = "AIDAVZPEY3OS25YJ425LA"
}
*/
