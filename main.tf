provider "aws" {
  region = "us-east-2"
}

module "db_subnet_group" {
  source          = "./modules/db_subnet_group"
  create          = var.create_db_subnet_group
  subnet_name     = var.db_subnet_group_name
  subnet_name_prefix     = var.db_subnet_group_use_name_prefix
  description     = var.db_subnet_group_description
  subnet_ids      = var.subnet_ids

  tags = merge(var.tags, var.db_subnet_group_tags)
}
module "db_parameter_group" {
  source          = "modules/db_parameter_group"
  create          = local.create_db_parameter_group
  parameter_name  = var.parameter_group_name
  parameter_name_prefix = var.parameter_group_use_name_prefix
  description     = var.parameter_group_description
  family          = var.family
  parameters      = var.parameters

  tags = merge(var.tags, var.db_parameter_group_tags)
}

module "db_option_group" {
  source                   = "modules/db_option_group"
  create                   = local.create_db_option_group  
  option_name              = var.option_group_name
  option_name_prefix       = var.option_group_use_name_prefix
  description              = var.option_group_description
  engine_name              = var.engine
  major_engine_version     = var.major_engine_version
  options                  = var.options
  timeouts                 = var.option_group_timeouts

  tags = merge(var.tags, var.db_option_group_tags)
}