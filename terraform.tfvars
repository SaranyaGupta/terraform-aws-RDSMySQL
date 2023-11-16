identifier="rds-mssql-test"
engine="sqlserver-se"
engine_version="14.00"
instance_class="db.t3.large"
allocated_storage= 3500
storage_type="gp2"
license_model="license-included"
db_name="testdb"
username="testuser"                        
port=1433
vpc_security_group_ids=["sg-0c5426001fd0fb679"]
network_type="IPV4"
availability_zone="us-east-2a"
multi_az=false
ca_cert_identifier="rds-ca-2019"
maintenance_window="Mon:00:00-Mon:03:00"
snapshot_identifier="test"
skip_final_snapshot=true
backup_retention_period=14
backup_window="09:46-10:16"
max_allocated_storage=5000
create_monitoring_role=true
enabled_cloudwatch_logs_exports=["error","general","slowquery"]
cloudwatch_log_group_retention_in_days=7
deletion_protection=true
#for mssql
character_set_name="Latin1_General_CI_AS"
db_instance_tags= {
    "Owner"       = "user",
    "Environment" = "test"}
db_subnet_group_name= "rdsmssql-subnet"
db_subnet_group_description= "test db rds mssql subnet group"
subnet_ids=["subnet-0b86a94123ccf1094","subnet-04eff055558594bd7","subnet-0bbf1e60c1a0f1db1"]
tags = {resource = "rdsmssql"}
db_subnet_group_tags= {name="rdsmssql-subnet"}
db_option_group_tags= {name="rdsmssql-option-group"}
db_parameter_group_tags= {name="rdsmssql-parameter-group"}
parameter_group_name= "rdsmssql-parameter-group"
parameter_group_description= "test db rds mssql parameter group"
family= "sqlserver-se-14.0"
major_engine_version= "14.00"
option_group_name= "rdsmssql-option-group"
option_group_description= "test db rds mssql option group" 
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
