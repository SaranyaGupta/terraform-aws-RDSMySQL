output "db_subnet_group_id" {
  description = "The db subnet group name"
  value       = try(aws_db_subnet_group.subnet_groups[0].id, null)
}

output "db_subnet_group_arn" {
  description = "The ARN of the db subnet group"
  value       = try(aws_db_subnet_group.subnet_groups[0].arn, null)
}