###Terraform config

terraform {
  backend "local" {}

  provider "aws" {
    region = "${var.region}"
  }
}

### Simple Notification Service
resource "aws_sns_topic" "dev-sns" {
  name         = "dev${lower(var.commonTags["environment"])}Alert"
  display_name = "dev${lower(var.commonTags["environment"])}"  
}
resource "aws_sns_topic" "inDevelopment-sns" {
  name         = "inDevelopment${lower(var.commonTags["environment"])}Alert"
  display_name = "inDevelopment${lower(var.commonTags["environment"])}"  
}
### Simple Notification Service
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
