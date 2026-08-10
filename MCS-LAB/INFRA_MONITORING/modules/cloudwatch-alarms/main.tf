locals {
  alarm_prefix = "${var.unique_application_identifier}_aws"

  object_class = "SERVER"

  object_instance = "${var.application_name}-${var.environment}"

  namespace = var.namespace
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name = "${local.alarm_prefix}::${local.object_class}::${local.object_instance}::CPU"

  alarm_description = "CPU utilization is above the configured threshold"

  namespace   = local.namespace
  metric_name = "cpu_usage_user"

  dimensions = {
    InstanceId = var.instance_id
  }

  statistic          = "Average"
  period             = 300
  evaluation_periods = 2

  threshold           = var.cpu_threshold
  comparison_operator = "GreaterThanThreshold"

  treat_missing_data = "notBreaching"
}

resource "aws_cloudwatch_metric_alarm" "memory_high" {
  alarm_name = "${local.alarm_prefix}::${local.object_class}::${local.object_instance}::MEMORY"

  alarm_description = "Memory utilization is above the configured threshold"

  namespace   = local.namespace
  metric_name = "mem_used_percent"

  dimensions = {
    InstanceId = var.instance_id
  }

  statistic          = "Average"
  period             = 300
  evaluation_periods = 2

  threshold           = var.memory_threshold
  comparison_operator = "GreaterThanThreshold"

  treat_missing_data = "notBreaching"
}

resource "aws_cloudwatch_metric_alarm" "filesystem_high" {
  alarm_name = "${local.alarm_prefix}::${local.object_class}::${local.object_instance}::FILESYSTEM"

  alarm_description = "Filesystem utilization is above the configured threshold"

  namespace   = local.namespace
  metric_name = "disk_used_percent"

  dimensions = {
    InstanceId = var.instance_id
    path       = "/"
    fstype     = "xfs"
  }

  statistic          = "Average"
  period             = 300
  evaluation_periods = 2

  threshold           = var.filesystem_threshold
  comparison_operator = "GreaterThanThreshold"

  treat_missing_data = "notBreaching"
}

resource "aws_cloudwatch_metric_alarm" "swap_high" {
  alarm_name = "${local.alarm_prefix}::${local.object_class}::${local.object_instance}::SWAP"

  alarm_description = "Swap utilization is above the configured threshold"

  namespace   = local.namespace
  metric_name = "swap_used_percent"

  dimensions = {
    InstanceId = var.instance_id
  }

  statistic          = "Average"
  period             = 300
  evaluation_periods = 2

  threshold           = var.swap_threshold
  comparison_operator = "GreaterThanThreshold"

  treat_missing_data = "notBreaching"
}

