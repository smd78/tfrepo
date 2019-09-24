###Terraform config

terraform {
  backend "local" {}

  provider "aws" {
    region = "ØP-west-1"
  }
}

module "vpc" {
  source     = "../modules/vpc/"
  envName    = "${upper(var.commonTags["environment"])}"
  cidrBlock  = "${var.cidrBlock}"
  commonTags = "${var.commonTags}"
}
