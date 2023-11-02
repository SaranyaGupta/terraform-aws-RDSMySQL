identifier="rds-mysql-test"
engine="MySQL Community"
engine_version="8.0.28"
instance_class="db.m5.xlarge"
allocated_storage= 150
storage_type="gp2"
license_model="General Public License"
db_name="testdb"
username="testuser"                          
port=3306
vpc_security_group_ids=["sg-0c5426001fd0fb679"]
network_type="IPv4"
availability_zone="us-east-2a"
multi_az=true
ca_cert_identifier="rds-ca-2019"
maintenance_window="Mon:00:00-Mon:03:00"
snapshot_identifier="test"
skip_final_snapshot=true
backup_retention_period=14
backup_window="09:46-10:16"
max_allocated_storage=250
create_monitoring_role=true
enabled_cloudwatch_logs_exports=["error","general","slowquery"]
cloudwatch_log_group_retention_in_days=7
deletion_protection=true
db_instance_tags= {
    "Owner"       = "user",
    "Environment" = "test"}
db_subnet_group_name= "rdsmysql-subnet"
db_subnet_group_description= "test db rds mysql subnet group"
subnet_ids=["subnet-04eff055558594bd7"]
tags = {resource = "rdsmysql"}
db_subnet_group_tags= {name="rdsmysql-subnet"}
db_option_group_tags= {name="rdsmysql-option-group"}
db_parameter_group_tags= {name="rdsmysql-parameter-group"}
parameter_group_name= "rdsmysql-parameter-group"
parameter_group_description= "test db rds mysql parameter group"
family= "mysql5.7"
major_engine_version= "5.7"
option_group_name= "rdsmysql-option-group"
option_group_description= "test db rds mysql option group" 