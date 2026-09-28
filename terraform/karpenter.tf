# Karpenter
resource "kubectl_manifest" "ec2_node_class" {
  count = length(var.karpenter)

  yaml_body = templatefile("${path.module}/assets/EC2NodeClass.yaml.tpl", {
    name               = var.karpenter[count.index].name
    instance_profile   = module.eks_cluster.nodes_instance_profile_name
    ami_id             = nonsensitive(data.aws_ssm_parameter.karpenter_ami[count.index].value)
    ami_family         = var.karpenter.ami_family
    security_group_ids = [module.eks_cluster.cluster_security_group_id]
    subnet_ids         = values(local.vpc.eks_subnet_ids)
  })
}

resource "kubectl_manifest" "node_pools" {
  count = length(var.karpenter)

  yaml_body = templatefile("${path.module}/assets/NodePool.yaml.tpl", {
    name                 = var.karpenter[count.index].name
    labels               = var.karpenter[count.index].labels
    consolidation_policy = var.karpenter[count.index].consolidation_policy
    consolidate_after    = var.karpenter[count.index].consolidate_after
    instance_families    = var.karpenter[count.index].instance_families
    capacity_types       = var.karpenter[count.index].capacity_types
    instance_sizes       = var.karpenter[count.index].instance_sizes
    zones                = coalesce(var.karpenter[count.index].zones, keys(local.vpc.eks_subnet_ids))
  })
}
