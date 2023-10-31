
  db_subnet_group_name            = "rdsmysql-subnet"
  db_subnet_group_description     = "test db rds mysql subnet group"
  subnet_ids      = "subnet-04eff055558594bd7"
  tags = ["resource" = "rdsmysql"]
  db_subnet_group_tags = ["name"="rdsmysql-subnet"]
  db_option_group_tags = ["name"="rdsmysql-option-group"]
  db_parameter_group_tags = ["name"="rdsmysql-parameter-group"]
  parameter_group_name = "rdsmysql-parameter-group"
  parameter_group_description = "test db rds mysql parameter group"
  family  = "mysql5.7"
   major_engine_version = "5.7"
  engine            = "mysql"
  option_group_name = "rdsmysql-option-group"
  option_group_description = "test db rds mysql option group"
  parameters = "[{
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]"
options = "[
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]"