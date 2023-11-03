resource "aws_db_subnet_group" "subnet_groups" {
  count = var.create ? 1 : 0

  name        = var.subnet_name
  #name_prefix = var.subnet_name_prefix
  description = var.description
  subnet_ids  = var.subnet_ids

  tags = merge(
    var.tags,
    {
      "Name" = var.subnet_name
    },
  )
}