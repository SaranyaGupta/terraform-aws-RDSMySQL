resource "aws_cloudwatch_metric_alarm" "cpu_utilization_too_high" {
  count               = var.create_high_cpu_alarm ? 1 : 0
  alarm_name          = var.name
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic
  threshold           = var.cpu_utilization_too_high_threshold
  alarm_description   = var.alarm_description
  alarm_actions       = aws_sns_topic.default.*.arn
  ok_actions          = aws_sns_topic.default.*.arn

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }
}
