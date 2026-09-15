module "eks_cluster" {
  source = "../../container-arch--aws-eks-modules/eks_cluster"

  environment  = var.environment
  project_name = var.project_name

  vpc_network         = local.vpc
  public_access_cidrs = [local.my_public_ip_cidr]

  auto_scale_options   = var.auto_scale_options
  nodes_instance_types = var.nodes_instance_types
}
