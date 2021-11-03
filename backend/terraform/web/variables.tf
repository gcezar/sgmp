variable "resource_prefix" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "key_name" {
  type = string
}

variable "staging_instance_type" {
  type = string
}

variable "staging_ami" {
  type = string
}

variable "staging_subnet_id" {
  type = string
}

variable "sg_id" {
  type = string
}

variable "user_data" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "staging_image_uri" {
  type = string
}

variable "staging_desired_count" {
  type = number
}

variable "consul_dns" {
  type = string
}

variable "task_role_policy_arn" {
  type = string
}

variable "execution_role_policy_arn" {
  type = string
}

variable "vpc_id" {
  type = string
}