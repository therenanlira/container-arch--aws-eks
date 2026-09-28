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

variable "nodes_config" {
  type = any
}

variable "karpenter" {
  description = "Karpenter configurations to create the YAML."
  type = object({
    name                 = string
    labels               = optional(map(string), {})
    ami_family           = optional(string, "AL2023")
    consolidation_policy = optional(string, "WhenEmptyOrUnderutilized")
    consolidate_after    = optional(string, "2m")
    instance_families    = list(string)
    capacity_types       = optional(list(string), ["spot"])
    instance_sizes       = list(string)
    zones                = optional(list(string)) # null = AZs das subnets do EKS
  })

  validation {
    condition     = contains(["AL2023", "Bottlerocket"], var.karpenter.ami_family)
    error_message = "ami_family must be AL2023 or Bottlerocket."
  }

  validation {
    condition     = contains(["WhenEmpty", "WhenEmptyOrUnderutilized"], var.karpenter.consolidation_policy)
    error_message = "consolidation_policy must be WhenEmpty or WhenEmptyOrUnderutilized."
  }

  validation {
    condition     = alltrue([for t in var.karpenter.capacity_types : contains(["spot", "on-demand", "reserved"], t)])
    error_message = "capacity_types accepts only spot, on-demand or reserved."
  }
}
