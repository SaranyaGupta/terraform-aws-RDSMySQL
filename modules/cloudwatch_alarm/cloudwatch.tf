resource "aws_cloudwatch_metric_alarm" "cpu_utilization_too_high" {
  count               = var.create_high_cpu_alarm ? 1 : 0
  alarm_name          = var.name
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_period
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic_period
  threshold           = var.metric_threshold
  alarm_description   = var.alarm_description
  alarm_actions       = var.actions_alarm
  ok_actions          = var.actions_ok
  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }
}


resource "aws_cloudwatch_metric_alarm" "memory_too_low" {
  count               = var.create_memory_too_low_alarm ? 1 : 0
  alarm_name          = var.name
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_period
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic_period
  threshold           = var.metric_threshold
  alarm_description   = var.alarm_description
  alarm_actions       = var.actions_alarm
  ok_actions          = var.actions_ok
  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "storage_space_too_low" {
 count               = var.create_storage_space_too_low_alarm ? 1 : 0
  alarm_name          = var.name
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_period
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic_period
  threshold           = var.metric_threshold
  alarm_description   = var.alarm_description
  alarm_actions       = var.actions_alarm
  ok_actions          = var.actions_ok
  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }
}
