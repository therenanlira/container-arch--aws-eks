locals {
  vpc = jsondecode(data.aws_ssm_parameter.vpc_network.insecure_value)

  my_public_ip_cidr = "${chomp(data.http.my_public_ip.response_body)}/32"

  tags = {
    Project     = var.project_name
    Region      = var.region
    Environment = var.environment
    ManagedBy   = "Terraform"
    Owner       = "SRE Team"
  }
}
