resource "aws_cloudwatch_metric_alarm" "cloudfront-4xx-Error-Percentage-cwAlarm" {
  alarm_name          = "${upper(var.commonTags["environment"])}-CloudFront-4xx-Error-Percentage"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "5"
  metric_name         = "4xxErrorRate"
  namespace           = "AWS/CloudFront"
  period              = "60"
  statistic           = "Average"
  threshold           = "10"
  alarm_description   = "CloudFront 4xx http error percentage breached 10% over a 5 minute period"
  actions_enabled     = "${var.alarmActionsEnabled}"
  alarm_actions       = ["${var.topicArn}"]

  dimensions {
    DistributionId = "${var.cloudfrontDistribution}"
    Region         = "Global"
  }

  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "cloudfront-5xx-Error-Percentage-cwAlarm" {
  alarm_name          = "${upper(var.commonTags["environment"])}-CloudFront-5xx-Error-Percentage"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "5"
  metric_name         = "5xxErrorRate"
  namespace           = "AWS/CloudFront"
  period              = "60"
  statistic           = "Average"
  threshold           = "10"
  alarm_description   = "CloudFront 5xx http error percentage breached 10% over a 5 minute period"
  actions_enabled     = "${var.alarmActionsEnabled}"
  alarm_actions       = ["${var.topicArn}"]

  dimensions {
    DistributionId = "${var.cloudfrontDistribution}"
    Region         = "Global"
  }

  treat_missing_data = "missing"
}
