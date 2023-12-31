output "db_option_group_id" {
  description = "The db option group id"
  value       = try(aws_db_option_group.option_group[*].id, null)
}
output "db_option_group_name" {
  description = "The db option group id"
  value       = try(aws_db_option_group.option_group[*].name, null)
}

output "db_option_group_arn" {
  description = "The ARN of the db option group"
  value       = try(aws_db_option_group.option_group[*].arn, null)
}
