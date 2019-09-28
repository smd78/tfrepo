output "vpcId" {
  value = "${aws_vpc.main.id}"
}

output "igwId" {
  value = "${aws_internet_gateway.igw.id}"
}

output "natGwAId" {
  value = "${aws_nat_gateway.natgwA.id}"
}

output "natGwBId" {
  value = "${aws_nat_gateway.natgwB.id}"
}

output "publicSubnetIds" {
  value = ["${aws_subnet.public.*.id}"]
}

output "privateSubnetIds" {
  value = ["${aws_subnet.private.*.id}"]
}

output "dhcpOptionsId" {
  value = "${aws_vpc_dhcp_options.dns_stuff.id}"
}
