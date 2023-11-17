output "id" {
  value = values(rds_security_groups in aws_security_group.rds_security_groups.[each.key.name]).id
}    
