output "id" {
  value = ({
    for k, rds_security_groups in aws_security_group.rds_security_groups : k => rds_security_groups.id
  })
}    
