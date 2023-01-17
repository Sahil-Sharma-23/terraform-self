provider "aws" {
  region = "ap-south-1"
}

# create AWS storage to store data
# resource "aws_db_instance" "prod" {
#   identifier           = "prod-mysql-rds"
#   allocated_storage    = 20
#   storage_type         = "gp2"
#   engine               = "mysql"
#   engine_version       = "5.7"
#   instance_class       = "db.t2.micro"
#   parameter_group_name = "default.mysql5.7"
#   skip_final_snapshot  = true
#   apply_immediately    = true
#   username             = "stem"
#   password             = data.random_password.my_random_password.value
# }

# Generate random password.
resource "random_password" "my_rds_pass" {
  length           = 20
  special          = true
  override_special = "_()!"
}

# Store password in SSM parameter.
resource "aws_ssm_parameter" "my_random_password" {
  name        = "/testing/random-pass/password-1"
  description = "My first random password stored in SSM parameter store."
  type        = "SecureString"
  value       = random_password.my_rds_pass.result
}

# Retrieve password from SSM Parameter store.
data "aws_ssm_parameter" "my_random_password" {
  name = "/testing/random-pass/password-1"
  # Make sure we retrieve data after it is stored in SSM Parameter.
  depends_on = [
    aws_ssm_parameter.my_random_password
  ]
}
# ---------------------------------------------
output "password_output" {
  value     = random_password.my_rds_pass.result
  sensitive = true
}

output "password" {
  value     = data.aws_ssm_parameter.my_random_password.value
  sensitive = true
}

