resource "aws_db_subnet_group" "subnet_groups" {
  name        = var.subnet_name
  description = var.description
  subnet_ids  = var.subnet_ids

  tags = merge(
    var.tags,
    {
      "Name" = var.subnet_name
    },
  )
}