locals {
  vpc = jsondecode(data.aws_ssm_parameter.vpc_network.insecure_value)

  my_public_ip_cidr = "${chomp(data.http.my_public_ip.response_body)}/32"

  karpenter_ami_ssm_paths = {
    AL2023       = "/aws/service/eks/optimized-ami/${module.eks_cluster.k8s_version}/amazon-linux-2023/x86_64/standard/recommended/image_id"
    Bottlerocket = "/aws/service/bottlerocket/aws-k8s-${module.eks_cluster.k8s_version}/x86_64/latest/image_id"
  }

  tags = {
    Project     = var.project_name
    Region      = var.region
    Environment = var.environment
    ManagedBy   = "Terraform"
    Owner       = "SRE Team"
  }
}
