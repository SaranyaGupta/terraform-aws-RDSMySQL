output "id" {
  value = values([for s in aws_security_group.rds_security_groups : s.name]).id
}
