output "alarm_name" {
  description = "The alarm name"
  value       = try(aws_cloudwatch_metric_alarm.cpu_utilization_too_high[*].alarm_name, null)
}