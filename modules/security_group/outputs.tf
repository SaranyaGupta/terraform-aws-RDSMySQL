output "id" {
  value = values(aws_security_group.rds_security_groups.[each.key].name).id
}    
