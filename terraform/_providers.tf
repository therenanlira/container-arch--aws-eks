terraform {
  required_version = "~> 1.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 3.4"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 3.2"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.3"
    }
  }
}

provider "aws" {
  allowed_account_ids = [var.account_id]
  region              = var.region
  default_tags {
    tags = local.tags
  }
}

provider "kubernetes" {
  host                   = module.eks_cluster.endpoint
  cluster_ca_certificate = module.eks_cluster.certificate_authority
  token                  = data.aws_eks_cluster_auth.default.token
}

provider "helm" {
  kubernetes = {
    host                   = module.eks_cluster.endpoint
    cluster_ca_certificate = module.eks_cluster.certificate_authority
    token                  = data.aws_eks_cluster_auth.default.token
  }
}
