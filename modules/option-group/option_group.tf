resource "aws_db_option_group" "option_group" {
  count = var.create ? 1 : 0

  name                     = var.option_name
  name_prefix              = var.option_name_prefix
  option_group_description = var.description
  engine_name              = var.engine_name
  major_engine_version     = var.major_engine_version
  tags = merge(
    var.tags,
    {
      "Name" = var.option_name
    },
  )

  timeouts {
    delete = lookup(var.timeouts, "delete", null)
  }

  lifecycle {
    create_before_destroy = true
  }
}