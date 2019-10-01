output "domainName" {
  value = "${aws_cloudfront_distribution.Devsite.domain_name}"
}

output "zoneId" {
  value = "${aws_cloudfront_distribution.Devsite.hosted_zone_id}"
}
