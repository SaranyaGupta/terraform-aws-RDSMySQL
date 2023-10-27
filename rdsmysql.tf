module "db_subnet_group" {
  source          = "./modules/db_subnet_group"
  name            = var.myDBSubnetGroup
  use_name_prefix = var.db_subnet_group_use_name_prefix
  description     = var.db_subnet_group_description
  subnet_ids      = var.subnet_ids

  tags = merge(var.tags, var.db_subnet_group_tags)
}

module "db_parameter_group" {
  source          = "./modules/db_parameter_group"
  name            = var.parameter_group_name
  use_name_prefix = var.parameter_group_use_name_prefix
  description     = var.parameter_group_description
  family          = var.family
  parameters      = var.parameters

  tags = merge(var.tags, var.db_parameter_group_tags)
}

module "db_option_group" {
  source = "./modules/db_option_group"
  name                     = var.option_group_name
  use_name_prefix          = var.option_group_use_name_prefix
  option_group_description = var.option_group_description
  engine_name              = var.engine
  major_engine_version     = var.major_engine_version
  options                  = var.options
  timeouts                 = var.option_group_timeouts

  tags = merge(var.tags, var.db_option_group_tags)
}

resource "aws_db_instance" "mysql" {
  depends_on                        = [module.db_subnet_group]
  create                			      = var.create
  identifier            			      = var.Identifier
  use_identifier_prefix 			      = var.Instance_use_identifier_prefix
  engine               				      = var.Engine
  engine_version       				      = var.EngineVersion
  instance_class       				      = var.DBInstanceClass
  allocated_storage    				      = var.DBAllocatedStorage
  storage_type         				      = var.StorageType
  storage_encrypted    				      = var.StorageEncrypted
  license_model        				      = var.LicenseModel
  db_name              				      = var.DBName
  username             				      = var.DBUsername
  password                          = var.DBPassword
  port                              = 3306
  iam_database_authentication_enabled= var.iam_database_authentication_enabled
  vpc_security_group_ids 			      = var.vpc_security_group_ids
  db_subnet_group_name   			      = var.myDBSubnetGroup
  parameter_group_name   			      = var.parameter_group_name_id
  option_group_name      			      = var.option_group
  network_type           			      = var.network_type
  availability_zone  				        = var.availability_zone
  multi_az           				        = true
  iops               				        = var.iops
  storage_throughput  				      = var.storage_throughput
  publicly_accessible               = no
  ca_cert_identifier                = var.ca_cert_identifier
  allow_major_version_upgrade 		  = var.allow_major_version_upgrade
  auto_minor_version_upgrade  		  = var.auto_minor_version_upgrade
  apply_immediately           		  = var.apply_immediately
  maintenance_window          		  = var.maintenance_window
  snapshot_identifier              	= var.snapshot_identifier
  copy_tags_to_snapshot             = var.copy_tags_to_snapshot
  skip_final_snapshot               = var.skip_final_snapshot
  final_snapshot_identifier_prefix  = var.final_snapshot_identifier_prefix
  performance_insights_enabled      = var.EnablePerformanceInsights
  performance_insights_retention_period= var.performance_insights_retention_period
  replicate_source_db                = var.replicate_source_db
  replica_mode                       = var.replica_mode
  backup_retention_period            = var.backup_retention_period
  backup_window                      = var.backup_window
  max_allocated_storage              = var.max_allocated_storage
  monitoring_interval                = var.monitoring_interval
  monitoring_role_arn                = var.monitoring_role_arn
  monitoring_role_name               = var.monitoring_role_name
  monitoring_role_use_name_prefix    = var.monitoring_role_use_name_prefix
  monitoring_role_description        = var.monitoring_role_description
  create_monitoring_role             = var.create_monitoring_role
  monitoring_role_permissions_boundary= var.monitoring_role_permissions_boundary
  character_set_name      			     = var.character_set_name
  nchar_character_set_name			     = var.nchar_character_set_name
  timezone                 			     = var.timezone
  enabled_cloudwatch_logs_exports    = var.enabled_cloudwatch_logs_exports
  create_cloudwatch_log_group        = var.create_cloudwatch_log_group
  cloudwatch_log_group_retention_in_days = var.cloudwatch_log_group_retention_in_days
  timeouts 							             = var.timeouts
  deletion_protection                = true
  delete_automated_backups           = var.delete_automated_backups
  restore_to_point_in_time           = var.restore_to_point_in_time
  s3_import                          = var.s3_import

  tags = merge(var.tags, var.db_instance_tags)
}

resource "aws_cloudwatch_log_group" "log_group" {
  create            = var.create_cloudwatch_log_group
  name              = var.cloudwatch_log_group_name
  retention_in_days = var.cloudwatch_log_group_retention_in_days
  kms_key_id        = var.cloudwatch_log_group_kms_key_id

  tags = var.tags
}

data "aws_iam_policy_document" "enhanced_monitoring" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "enhanced_monitoring" {
  count = var.create_monitoring_role ? 1 : 0

  name                 = local.monitoring_role_name
  name_prefix          = local.monitoring_role_name_prefix
  assume_role_policy   = data.aws_iam_policy_document.enhanced_monitoring.json
  description          = var.monitoring_role_description
  permissions_boundary = var.monitoring_role_permissions_boundary

  tags = merge(
    {
      "Name" = format("%s", var.monitoring_role_name)
    },
    var.tags,
  )
}

resource "aws_iam_role_policy_attachment" "enhanced_monitoring" {
  count = var.create_monitoring_role ? 1 : 0

  role       = aws_iam_role.enhanced_monitoring[0].name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}
