apiVersion: karpenter.sh/v1
kind: NodePool
metadata:
  name: ${name}
spec:
  disruption:
    consolidationPolicy: ${consolidation_policy}
    consolidateAfter: ${consolidate_after}
  template:
    metadata:
      labels: ${jsonencode(labels)}
    spec:
      requirements:
        - key: karpenter.k8s.aws/instance-family
          operator: In
          values: ${jsonencode(instance_families)}

        - key: karpenter.sh/capacity-type
          operator: In
          values: ${jsonencode(capacity_types)}

        - key: karpenter.k8s.aws/instance-size
          operator: In
          values: ${jsonencode(instance_sizes)}

        - key: topology.kubernetes.io/zone
          operator: In
          values: ${jsonencode(zones)}

      nodeClassRef:
        group: karpenter.k8s.aws
        kind: EC2NodeClass
        name: ${name}
