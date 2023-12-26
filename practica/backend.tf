# terraform {
#   required_version = ">= 1.0.0"

#   backend "s3" {
#     region   = "us-east-1"
#     bucket   = "edaniel-test-us-east-1-prod-terraform-state"
#     key      = "terraform.tfstate"
#     profile  = ""
#     role_arn = "arn:aws:iam::236609069548:role/aws-service-role/rds.amazonaws.com/AWSServiceRoleForRDS"
#     encrypt  = "true"

#     dynamodb_table = "edaniel-test-us-east-1-prod-terraform-state-lock"
#   }
# }
