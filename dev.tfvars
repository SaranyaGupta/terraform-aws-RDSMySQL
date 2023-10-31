  create_db_subnet_group          = "true"
  db_subnet_group_name            = "rdsmysql-subnet"
  db_subnet_group_use_name_prefix = "testdb"
  db_subnet_group_description     = "test db rds mysql subnet group"
  subnet_ids      = "subnet-04eff055558594bd7"
  tags = ["resource" = "rdsmysql"]
  db_subnet_group_tags = ["name"="rdsmysql-subnet"]