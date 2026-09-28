# General
account_id   = "150100906110"
region       = "us-east-2"
environment  = "prd"
project_name = "ct-arch"

# EKS
auto_scale_options = {
  min = 1
  max = 2
  des = 1
}

nodes_instance_types = [
  "m7i-flex.large",
  "c7i-flex.large",
  # "t4g.small"
]

nodes_config = [
  {
    name          = "default"
    capacity_os   = "AMAZON_LINUX"
    capacity_type = "ON_DEMAND"
  },
  # {
  #   name          = "spot"
  #   capacity_os   = "AMAZON_LINUX"
  #   capacity_type = "SPOT"
  # },
  # {
  #   name          = "bottlerocket"
  #   capacity_os   = "BOTTLEROCKET"
  #   capacity_type = "ON_DEMAND"
  # },
  # {
  #   name          = "bottlerocket-spot"
  #   capacity_os   = "BOTTLEROCKET"
  #   capacity_type = "SPOT"
  #   ami_type      = "BOTTLEROCKET_x86_64"
  # },
  # {
  #   name          = "graviton"
  #   capacity_os   = "AMAZON_LINUX"
  #   capacity_type = "ON_DEMAND"
  #   capacity_arch = "arm64"
  #   ami_type      = "AL2023_ARM_64_STANDARD"
  # },
  # {
  #   name          = "graviton-spot"
  #   capacity_os   = "AMAZON_LINUX"
  #   capacity_type = "SPOT"
  #   capacity_arch = "arm64"
  #   ami_type      = "AL2023_ARM_64_STANDARD"
  # },
  # {
  #   name          = "bottlerocket-critical"
  #   capacity_os   = "BOTTLEROCKET"
  #   capacity_type = "ON_DEMAND"
  #   severity      = "critical"
  # },
  # {
  #   name          = "bottlerocket-soft"
  #   capacity_os   = "BOTTLEROCKET"
  #   capacity_type = "SPOT"
  #   severity      = "soft"
  # }
]

# Karpenter
karpenter = [
  {
    name = "critical"
    labels = {
      workload = "etc"
    }
    ami_family           = "AL2023"
    consolidation_policy = "WhenEmptyOrUnderutilized"
    consolidate_after    = "2m"
    instance_families    = ["c7i-flex", "m7i-flex"] # conta Free plan: só tipos free-tier eligible
    capacity_types       = ["spot"]
    instance_sizes       = ["large"]
    # zones = ["us-east-2a", "us-east-2b"] # opcional; padrão = AZs das subnets do EKS
  },
  {
    name = "general"
    labels = {
      workload = "etc"
    }
    ami_family           = "Bottlerocket"
    consolidation_policy = "WhenEmptyOrUnderutilized"
    consolidate_after    = "2m"
    instance_families    = ["c7i-flex", "m7i-flex"] # conta Free plan: só tipos free-tier eligible
    capacity_types       = ["spot"]
    instance_sizes       = ["large"]
    # zones = ["us-east-2a", "us-east-2b"] # opcional; padrão = AZs das subnets do EKS
  }
]
