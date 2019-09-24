resource "aws_vpc" "main" {
  cidr_block = "${var.cidrBlock}"
  tags      = "${var.commonTags}"
}
