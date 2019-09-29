resource "aws_route53_zone" "zone" {
    name = "${var.root_domain_name}"
}

resource "aws_route53_record" "www" {
  zone_id = "${aws_route53_zone.zone.zone_id}"
  name = "${var.www_domain_name}"
  type = "A"

  alias = {
      name = "${var.r53AliasForDomainName}"
      zone_id = "${var.r53AliasForHostedZone}"
      evaluate_target_health = false
  }
}
