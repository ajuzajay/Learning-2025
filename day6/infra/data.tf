# State can be either: available, information, impaired, or unavailable
data "aws_availability_zones" "available" {
  state = "available"

}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

output "accountid" {
  value = data.aws_caller_identity.current.account_id

}
