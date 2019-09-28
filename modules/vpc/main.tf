resource "aws_vpc" "main" {
  cidr_block = "${var.cidrBlock}"
  tags       = "${merge(var.commonTags,map("role","vpc","name","${upper(var.commonTags["environment"])}-vpc"))}"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.main.id}"
  tags   = "${merge(var.commonTags,map("role","Internet Gateway","name","${upper(var.commonTags["environment"])}-igw"))}"
}

resource "aws_eip" "natgwA" {
  vpc = true
}

resource "aws_nat_gateway" "natgwA" {
  subnet_id     = "${element(aws_subnet.public.*.id, 0)}"
  allocation_id = "${aws_eip.natgwA.id}"
  tags          = "${merge(var.commonTags,map("role","NAT Gateway","name","${upper(var.commonTags["environment"])}-NAT-GW-A"))}"
}

resource "aws_eip" "natgwB" {
  vpc = true
}

resource "aws_nat_gateway" "natgwB" {
  subnet_id     = "${element(aws_subnet.public.*.id, 1)}"
  allocation_id = "${aws_eip.natgwB.id}"
  tags          = "${merge(var.commonTags,map("role","NAT Gateway","name","${upper(var.commonTags["environment"])}-NAT-GW-B"))}"
}

resource "aws_subnet" "public" {
  count             = "${length(var.publicSubnets)}"
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.publicSubnets[count.index]}"
  availability_zone = "${var.availabilityZones[count.index]}"

  lifecycle {
    create_before_destroy = true
  }

  tags = "${merge(var.commonTags,map("role","VPC Subnet","name","${upper(var.commonTags["environment"])}-${var.availabilityZones[count.index]}-public"))}"
}

resource "aws_subnet" "private" {
  count             = "${length(var.privateSubnets)}"
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.privateSubnets[count.index]}"
  availability_zone = "${var.availabilityZones[count.index]}"

  lifecycle {
    create_before_destroy = true
  }

  tags = "${var.commonTags}"
}

resource "aws_vpc_dhcp_options" "dns_stuff" {
  domain_name_servers = "${var.dns}"
  tags                = "${merge(var.commonTags, map("role", "dns"))}"
}

resource "aws_vpc_dhcp_options_association" "dns_stuff" {
  vpc_id          = "${aws_vpc.main.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.dns_stuff.id}"
}
