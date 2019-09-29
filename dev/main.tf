###Terraform config

terraform {
  backend "local" {}
  provider "aws" {
    region = "eu-west-1"
}

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
  source = "../modules/s3-www"
  envName           = "${upper(var.commonTags["environment"])}"
  bucketName = "${var.www_domain_name}"
  commonTags = "${var.commonTags}"
}

#cloudfront
module "cloudfront" {
  source = "../modules/cloudfront"
  www_domain_name = "${var.www_domain_name}"
  website_endpoint = "${module.s3-www.website_endpoint}"
}

#iam

#route53
module "r53" {
  source = "../modules/r53"
  root_domain_name = "${var.root_domain_name}"
  www_domain_name = "${var.www_domain_name}"
  r53AliasForDomainName = "${module.cloudfront.domainName}"
  r53AliasForHostedZone = "${module.cloudfront.zoneId}"
  
}


#cert manager

#file upload to s3