variable "cidrBlock" {}

variable "commonTags" {
  type = "map"
}

variable "envName" {}

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
