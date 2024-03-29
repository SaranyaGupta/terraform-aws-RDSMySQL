create_db_option_group          	= true
create_db_subnet_group    			= true
create_db_parameter_group 			= true
create_db_instance        			= true
create_cloudwatch_log_group			= true
create_high_cpu_alarm           	= true
create_memory_too_low_alarm			= true
create_storage_space_too_low_alarm	= true
##Cloudwatch alarm name prefix format --> <cwa>-<rds>-<rds engine>-<App_Name>-<Environment>##
name                                = "cwa-rds-mysql-test"
##RDS identifier format --> <rds>-<App_Name>-<rds engine>-<Environment>-<Numeric>##
identifier                          ="rds-mysql-test"
engine                              ="mysql"
engine_version                      ="8.0.35"
instance_class                      ="db.t3.medium"
allocated_storage                   = 10
storage_type                        ="gp2"
license_model                       ="general-public-license"
db_name                             ="testdb"
username                            ="testuser"                        
security_group_ids                  =["sg-0c5426001fd0fb679"]
network_type                        ="IPV4"
availability_zone                   ="us-east-2a"
multi_az                            =true
ca_cert_identifier                  ="rds-ca-2019"
maintenance_window                  ="Mon:00:00-Mon:03:00"
snapshot_identifier                 ="test"
skip_final_snapshot                 =true
backup_retention_period             =14
backup_window                       ="09:46-10:16"
max_allocated_storage               =250
create_monitoring_role              =true
enabled_cloudwatch_logs_exports     =["error","general","slowquery"]
cloudwatch_log_group_retention_in_days=7
deletion_protection                 =true
##MONITORING ROLE NAME FORMAT --> <role>-<aws-service>-<App-name>-<Environment>-<Functional-use>##
monitoring_role_name                ="rds-mysql-monitoring-role"
db_instance_tags                    = {
ApplicationOwner= "abc@gmail.com",
BusinessOwner="abc@gmail.com",
CostCenterDept="IS Infrastructure",
Environment="Test",
Product="xyz",
Role="Database",
ServiceCriticality="High",
SupportContact="Support@gmail.com"
}
##SUBNET GROUP NAME format --> <rds-sg>_<App_Name>_<rds engine>_<Environment>_<Version>_<Numeric>##
db_subnet_group_name           ="rdsmysql-subnet"
db_subnet_group_description    = "test db rds mysql subnet group"
subnet_ids                     =["subnet-0b86a94123ccf1094","subnet-04eff055558594bd7","subnet-0bbf1e60c1a0f1db1"]
tags                           = {resource = "rdsmysql"}
db_subnet_group_tags           = {name="rdsmysql-subnet"}
db_option_group_tags           = {name="rdsmysql-option-group"}
db_parameter_group_tags        = {name="rdsmysql-parameter-group"}
##PARAMETER GROUP NAME format --> <rds-pg>_<App_Name>_<rds engine>_<Environment>_<Version>_<Numeric>##
parameter_group_name           = "rdsmysql-parameter-group"
parameter_group_description    = "test db rds mysql parameter group"
family                         = "mysql8.0"
major_engine_version           = "8.0"
##OPTION GROUP NAME format --> <rds-og>_<App_Name>_<rds engine>_<Environment>_<Version>_<Numeric>##
option_group_name              = "rdsmysql-option-group"
option_group_description       = "test db rds mysql option group" 
parameters = [{
     "name"  = "character_set_client"
     "value" = "utf8mb4"
      },
    {
      "name"  = "character_set_server"
      "value" = "utf8mb4"
    }]
options = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
]
security_rules = {
  rds_sg1_mysql = {
    "rule1" = { type = "ingress", from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"], description = "For SSH" },
    "rule2" = { type = "ingress", from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"], description = "For SSH" },
    "rule3" = { type = "egress", from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"], description = "For SSH" }
  }
  rds_sg2_mysql = {
    "rule1" = { type = "ingress", from_port = 22, to_port = 22, protocol = "tcp" , cidr_blocks = ["0.0.0.0/0"], description = "For SSH"}
  }
}
vpc_id            = "vpc-0419802ed12eec58a"
existing_sg_rules = {
sg-0c5426001fd0fb679 = {
"rule1" = { type = "ingress", from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"], description = "For SSH" }
}
#,sg-0294c098f15df980e = {
#"rule1" = { type = "ingress", from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"], description = "For SSH" }
#}
}
ok_alarm           = ["arn:aws:sns:us-east-2:215691912540:RDSAlarm"]
actions_alarm      = ["arn:aws:sns:us-east-2:215691912540:RDSAlarm"]

##optional variables. default values mentioned in variable.tf file##
/*
instance_use_identifier_prefix
custom_iam_instance_profile
storage_throughput
storage_encrypted
kms_key_id
replicate_source_db
replica_mode
iam_database_authentication_enabled
domain
domain_iam_role_name
skip_final_snapshot
final_snapshot_identifier_prefix
db_name
manage_master_user_password
master_user_secret_kms_key_id
port
vpc_security_group_ids
iops
publicly_accessible
monitoring_interval
monitoring_role_arn
monitoring_role_name
monitoring_role_use_name_prefix
monitoring_role_description
monitoring_role_permissions_boundary
allow_major_version_upgrade
auto_minor_version_upgrade
apply_immediately
blue_green_update
restore_to_point_in_time
s3_import
db_subnet_group_use_name_prefix
parameters
timezone
nchar_character_set_name
timeouts
option_group_timeouts
performance_insights_enabled
performance_insights_retention_period
performance_insights_kms_key_id
delete_automated_backups
cloudwatch_log_group_kms_key_id
db_instance_role_associations
CPU_threshold
Memory_threshold
storage_threshold
statistic
period
*/
