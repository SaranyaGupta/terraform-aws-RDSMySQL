provider "aws" {
  region = "us-east-2"
}

module "db_subnet_group" {
  source          = "modules/db_subnet_group"
  create          = var.create_db_subnet_group
  name            = var.db_subnet_group_name
  use_name_prefix = var.db_subnet_group_use_name_prefix
  description     = var.db_subnet_group_description
  subnet_ids      = var.subnet_ids

  tags = merge(var.tags, var.db_subnet_group_tags)
}