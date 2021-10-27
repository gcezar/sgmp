variable "region" {
  type = string
}

variable "cidr" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "resource_prefix" {
  type = string
  default = "gismolab_sgmp"
}

variable "tags" {
  type = map(string)
  default = {
    Project = "sgmp"
  }
}

variable "key_name" {
  type = string
}

variable "bastion_instance_type" {
  type = string
  default = "t3.micro"
}

variable "consul_ami" {
  type = string
  default = "ami-04001a4818bb973ab"
}

variable "consul_instance_type" {
  type = string
  default = "t3.micro"
}

variable "tsdb_ami" {
  type = string
  default = "ami-0cc7deef96971c4b0"
}

variable "tsdb_instance_type" {
  type = string
  default = "t3.medium"
}

variable "tsdb_volume_size" {
  type = number
}

variable "tsdb_cluster_size" {
  type = number
}