###Terraform config

terraform {
  backend "local" {}

  provider "aws" {
    region = "eu-west-1"
  }

}
  provider "aws" {
  # us-east-1 instance
  region = "us-east-1"
  alias = "use1"
}

module "vpc" {
  source            = "../modules/vpc/"
  envName           = "${upper(var.commonTags["environment"])}"
  cidrBlock         = "${var.cidrBlock}"
  publicSubnets     = "${var.publicSubnets}"
  privateSubnets    = "${var.privateSubnets}"
  availabilityZones = "${var.availabilityZones}"
  dns               = "${var.dns}"
  commonTags        = "${var.commonTags}"
}

#s3
module "s3-www" {
  source     = "../modules/s3-www"
  envName    = "${upper(var.commonTags["environment"])}"
  bucketName = "${var.www_domain_name}"
  commonTags = "${var.commonTags}"
}

#cloudfront
module "cloudfront" {
  source           = "../modules/cloudfront"
  acmCertificate   = "${aws_acm_certificate.certificate.arn}"
  www_domain_name  = "${var.www_domain_name}"
  website_endpoint = "${module.s3-www.website_endpoint}"
}

#iam

#route53
module "r53" {
  source                = "../modules/r53"
  root_domain_name      = "${var.root_domain_name}"
  www_domain_name       = "${var.www_domain_name}"
  r53AliasForDomainName = "${module.cloudfront.domainName}"
  r53AliasForHostedZone = "${module.cloudfront.zoneId}"
}

#cert manager
resource "aws_acm_certificate" "certificate" {
  domain_name       = "*.${var.root_domain_name}"
  provider          = "aws.use1"
  validation_method = "DNS"
  subject_alternative_names = ["${var.root_domain_name}"]
}
