output "cpu_alarm_name" {
  value = aws_cloudwatch_metric_alarm.cpu_high.alarm_name
}

output "memory_alarm_name" {
  value = aws_cloudwatch_metric_alarm.memory_high.alarm_name
}

output "filesystem_alarm_name" {
  value = aws_cloudwatch_metric_alarm.filesystem_high.alarm_name
}

output "swap_alarm_name" {
  value = aws_cloudwatch_metric_alarm.swap_high.alarm_name
}