variable "commonTags" {
  type        = "map"
  description = "map of commontags"
}

variable "cidrBlock" {}

variable "publicSubnets" {
  type = "list"
}

variable "privateSubnets" {
  type = "list"
}

variable "availabilityZones" {
  type = "list"
}

variable "dns" {
  type = "list"
}

#s3wwww

variable "www_domain_name" {}

variable "root_domain_name" {}
