  create          = "true"
  name            = "rdsmysql-subnet"
  use_name_prefix = "testdb"
  description     = "test db rds mysql subnet group"
  subnet_ids      = "subnet-04eff055558594bd7"

  tags = ["resource" = "rdsmysql"]
 db_subnet_group_tags = ["name"="rdsmysql-subnet"]