locals {
  flat_security_rules = merge([
      for sg, rules in var.security_rules:
         {
           for rule, vals in rules:
             "${sg}-${rule}" => merge(vals, {sg_name = sg})
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
  security_group_id = aws_security_group.ec2_security_groups[each.value.sg_name].id
}
