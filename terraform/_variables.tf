variable "account_id" {
  type = string
}

variable "region" {
  type = string
}

variable "environment" {
  type = string
}

variable "project_name" {
  type = string
}

variable "auto_scale_options" {
  type = any
}

variable "nodes_instance_types" {
  type = any
}
