output "instance_profile_name" {
  value = aws_iam_instance_profile.cloudwatch_profile.name
}

output "role_name" {
  value = aws_iam_role.cloudwatch_role.name
}

output "role_arn" {
  value = aws_iam_role.cloudwatch_role.arn
}