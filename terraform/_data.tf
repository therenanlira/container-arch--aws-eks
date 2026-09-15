data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_ssm_parameter" "vpc_network" {
  name = "/${var.environment}/${var.region}/${var.project_name}/vpc-network"
}

data "http" "my_public_ip" {
  url = "https://checkip.amazonaws.com"

  lifecycle {
    postcondition {
      condition     = self.status_code == 200 && can(cidrhost("${chomp(self.response_body)}/32", 0))
      error_message = "Não foi possível obter o IP público em checkip.amazonaws.com."
    }
  }
}

data "aws_eks_cluster_auth" "default" {
  name = module.eks_cluster.name
}
