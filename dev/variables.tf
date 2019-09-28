variable "commonTags" {
  type        = "map"
  description = "map of commontags"
}

variable "cidrBlock" {}

variable "region" {
  type = "string"
}

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
