output "id" {
  value = values(aws_security_group.rds_security_groups[each.value.name]).id
}    
