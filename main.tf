provider "aws" {
  region = "us-east-2"
}
locals {
  create_db_subnet_group    = var.create_db_subnet_group
  create_db_parameter_group = var.create_db_parameter_group
  create_db_instance        = var.create_db_instance
  create_db_option_group = var.create_db_option_group
  }

module "db_subnet_group" {
  source          = "./modules/db_subnet_group"
  create          = local.create_db_subnet_group
  subnet_name     = var.db_subnet_group_name
  description     = var.db_subnet_group_description
  subnet_ids      = var.subnet_ids

  tags = merge(var.tags, var.db_subnet_group_tags)
}
module "db_parameter_group" {
  source          = "./modules/db_parameter_group"
  create          = local.create_db_parameter_group
  parameter_name  = var.parameter_group_name
  description     = var.parameter_group_description
  family          = var.family
  parameters      = var.parameters

  tags = merge(var.tags, var.db_parameter_group_tags)
}

module "db_option_group" {
  source                   = "./modules/db_option_group"
  create                   = local.create_db_option_group 
  option_name              = var.option_group_name
  description              = var.option_group_description
  engine_name              = var.engine
  major_engine_version     = var.major_engine_version
  options                  = var.options
  timeouts                 = var.option_group_timeouts

  tags = merge(var.tags, var.db_option_group_tags)
}
locals {
  name = var.security_rules
  flat_security_rules = merge([
      for sg, rules in var.security_rules:
         {
           for rule, vals in rules:
             "${sg}-${rule}" => merge(vals, {name = sg})
         }
    ]...) # please, do NOT remove the dots
  flat_security_rules1 = merge([
      for sg, rules in var.existing_sg_rules:
         {
           for rule, vals in rules:
             "${sg}-${rule}" => merge(vals, {name = sg})
         }
    ]...) # please, do NOT remove the dots
}
resource "aws_security_group" "ec2_security_groups" {
  for_each = local.name
  name   = each.key
  vpc_id = "vpc-0777935da25d06fe3"
}

resource "aws_security_group_rule" "rules" {
  for_each          = local.flat_security_rules
  type              = each.value.type
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
  description       = each.value.description
  security_group_id = aws_security_group.ec2_security_groups[each.value.name].id
}

resource "aws_security_group_rule" "existing_sg" {
  for_each          = local.flat_security_rules1
  type              = each.value.type
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
  description       = each.value.description
  security_group_id = aws_security_group.selected[each.value.name].id
}

module "db_instance" {
  source = "./modules/rdsmysql"
  create                              = local.create_db_instance
  identifier                          = var.identifier
  use_identifier_prefix               = var.instance_use_identifier_prefix
  engine                              = var.engine
  engine_version                      = var.engine_version
  instance_class                      = var.instance_class
  allocated_storage                   = var.allocated_storage
  storage_type                        = var.storage_type
  storage_encrypted                   = var.storage_encrypted
  kms_key_id                          = var.kms_key_id
  license_model                       = var.license_model
  db_name                             = var.db_name
  username                            = var.username
  password                            = var.manage_master_user_password ? null : var.password
  #port                                = var.port
  domain                              = var.domain
  domain_iam_role_name                = var.domain_iam_role_name
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  custom_iam_instance_profile         = var.custom_iam_instance_profile
  manage_master_user_password         = var.manage_master_user_password
  master_user_secret_kms_key_id       = var.master_user_secret_kms_key_id
  vpc_security_group_ids              = var.vpc_security_group_ids
  db_subnet_group_name                = "${module.db_subnet_group.db_subnet_group_name[0]}"
  parameter_group_name                = "${module.db_parameter_group.db_parameter_group_name[0]}"
  option_group_name                   = "${module.db_option_group.db_option_group_name[0]}"
  network_type                        = var.network_type
  availability_zone                   = var.availability_zone
  multi_az                            = var.multi_az
  iops                                = var.iops
  storage_throughput                  = var.storage_throughput
  publicly_accessible                 = var.publicly_accessible
  ca_cert_identifier                  = var.ca_cert_identifier

  allow_major_version_upgrade         = var.allow_major_version_upgrade
  auto_minor_version_upgrade          = var.auto_minor_version_upgrade
  apply_immediately                   = var.apply_immediately
  maintenance_window                  = var.maintenance_window
  blue_green_update                   = var.blue_green_update

  #snapshot_identifier                 = var.snapshot_identifier
  #copy_tags_to_snapshot               = var.copy_tags_to_snapshot
  skip_final_snapshot                 = var.skip_final_snapshot
  #final_snapshot_identifier_prefix    = var.final_snapshot_identifier_prefix

  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_retention_period
  performance_insights_kms_key_id       = var.performance_insights_enabled ? var.performance_insights_kms_key_id : null

  replicate_source_db                  = var.replicate_source_db
  replica_mode                         = var.replica_mode
  backup_retention_period              = var.backup_retention_period
  backup_window                        = var.backup_window
  max_allocated_storage                = var.max_allocated_storage
  monitoring_interval                  = var.monitoring_interval
  monitoring_role_arn                  = var.monitoring_role_arn
  monitoring_role_name                 = var.monitoring_role_name
  monitoring_role_use_name_prefix      = var.monitoring_role_use_name_prefix
  monitoring_role_description          = var.monitoring_role_description
  create_monitoring_role               = var.create_monitoring_role
  monitoring_role_permissions_boundary = var.monitoring_role_permissions_boundary

  character_set_name                   = var.character_set_name
  nchar_character_set_name             = var.nchar_character_set_name
  timezone                             = var.timezone

  enabled_cloudwatch_logs_exports        = var.enabled_cloudwatch_logs_exports
  create_cloudwatch_log_group            = var.create_cloudwatch_log_group
  cloudwatch_log_group_retention_in_days = var.cloudwatch_log_group_retention_in_days
  cloudwatch_log_group_kms_key_id        = var.cloudwatch_log_group_kms_key_id

  timeouts                               = var.timeouts

  deletion_protection      = var.deletion_protection
  delete_automated_backups = var.delete_automated_backups
  restore_to_point_in_time = var.restore_to_point_in_time
  s3_import                = var.s3_import

  tags = merge(var.tags, var.db_instance_tags)
}
module "cloudwatch_alarm" {
  source =  "./modules/cloudwatch_alarm"
  create_high_cpu_alarm = true
  name                  = "test-cpu-alarm"
  comparison_operator    = "GreaterThanOrEqualToThreshold"
  evaluation_period = "5"
  metric_name  = "CPUUtilization"
  namespace        = "AWS/RDS"
  period           ="120" #seconds
 statistic_period = "Average"
 metric_threshold = "80"
  alarm_description = "This metric monitors RDS CPU utilization"
  actions_alarm = ["arn:aws:sns:us-east-2:215691912540:RDSAlarm"]
  actions_ok = ["arn:aws:sns:us-east-2:215691912540:RDSAlarm"]
  db_instance_id = "${module.db_instance.db_instance_identifier}"
  db_instance_class = "db.t3a.large"
}
