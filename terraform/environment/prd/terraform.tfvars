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
  "c7i-flex.large"
]
